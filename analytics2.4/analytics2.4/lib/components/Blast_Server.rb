
=begin
 * Blast_Server.rb
 *
 * Author :  P.S.Mohamed Hussain
 * Version:  1.0.0
 * Created:  10/05/07
 * Last Modified: 06/05/07
 *
 * Copyright (c) 2003-2006 by CalChennai Mobile-worx  Pvt Ltd
 *
 * All rights reserved.
 *
 *1059 Opal Way, Gardena, CA 90247 
 *
 *Y222, 2nd Floor, 2nd Avenue, Anna Nagar, Chennai 600040
 * www.mobile-worx.com
 *
 * INTELLECTUAL PROPERTY RIGHTS NOTICE
 * ALL IPR including that of source code, design documents, algorithms, flow documents,project plans,
 * reviews, images,architectural documents and other documents related to this document are held by
 * Mobile-Worx technologies and any modification, alteration,re-engineering, reverse engineering or
 * any change targeted towards any kinds of use would be severely dealt with under the Federal Laws
 * of United States of America & Republic of India
 *
 *
 * Contact us at 
 * info@mobile-worx.com
 *
 *Notes: This class is used to send the bulk sms or wap messages,It is getting the phone number file from Rails root
 *Version: 0.1
 
=end
#-------------------------------------------------------------------------------------------------------------------#
require 'drb'
require 'dbi'
require 'components/ZDc'
require 'components/ZAd'
require 'components/EmbedAd'
class Blast_Server
  @debug=true
  
  $phoneLength = 0
  FILE_ERROR=40
  NODATA=41
  QUERY_ERROR=42
  CLASS_ERROR=43
  CLASS_METHOD_ERROR=44
  GATEWAY_ERROR=45
  print "INFO : SMS Blast Server is starting."
  sleep(1)
  print "."
  sleep(1)
  print "."
  sleep(1)
  print ".\n"
  print "INFO : SMS Blast Server running port :: "
  sleep(2)
  print "9199\n"
  print "INFO : Connecting database server."
  report=nil
  
  sleep(1)
  print "."
  sleep(1)
  print "."
  sleep(1)
  def initialize
    begin
      #Connecting the Database Server
      #@dbh = Mysql.real_connect(ZDc::DATABASE,ZDc::USERNAME,ZDc::PASSWORD) 
      @dbh = DBI.connect(ZDc::DATABASE, ZDc::USERNAME,ZDc::PASSWORD)
      report="Connected"
      begin
        @obj=nil
        #Connecting the DRuby Gateway server
        @obj=DRbObject.new(nil,'druby://192.168.1.2:2882')
        rescue 
        return GATEWAY_ERROR
      end
      
      rescue Exception=>e
      report ="Database is not connected,contact your development team"+e.to_s
    end        
  end
  print " :: #{report}\n"
  #Thread.new do
  #Starting the thread, when request comes in
  
  def phoneLength
    return $phoneLength
  end
  
  #Name: blastMessage
  #Purpose: This method send the bulk sms or wap messages
  #version: 1.0
  #Last modified:
  #To use this method: This method is working as a server
  #Note: This method getting the phone number file from Rails root and this class placed in Rails script folder
  def blastADMessage(path,username,password,serviceId,userId,fileId,data,type,isAd, cid)
    puts "EMbed ADs"
    sth=nil
    Thread.new do
      if !@obj
        return GATEWAY_ERROR
      end
      sql="select phone_file from mobileuploads where id=#{fileId}"
      file=''
      begin
        #getting the uploaded file name from database
        sth = @dbh.prepare(sql)
        sth.execute                
        rescue Exception =>e
        return QUERY_ERROR
      end
      if sth.rows>0
        while row=sth.fetch do
          file=row[0]
        end
      else
        return NODATA
      end            
      begin
        #getting the file from rails root folder
        #grtting the file by service id and file name
        @arr=IO.readlines("#{path}/public/mobileupload/phone_file/#{fileId}/#{file}")   
        folderPath="#{path}/public/mobileupload/phone_file/#{fileId}/#{file}"
        #delete the file from rails root after reading the content of the file
        #garbage collection
        File.delete(folderPath)
        rescue
        return FILE_ERROR
      end
      #converting the file content into array
      @phone=@arr.to_a
      if(@phone.length==0)
        return NODATA
      end
      $phoneLength = @phone.length
      for i in 0...@phone.length
        #Split the phone number by '-' to get the location id and phone number
        locId=@phone[i].split("-")
        val=locId[1].split(",")
        #Add to Database 
        sql="select max(id) from optinlists"
        begin
          sth = @dbh.prepare(sql)
          sth.execute                    
          @id=0
          while row=sth.fetch do
            @id=row[0]
          end                    
          @id=@id.to_i+1
          rescue

          return QUERY_ERROR
        end
        sql="insert into optinlists (id,phone_no,approved,service_id,approval_message,location_code,user_id,response) values (#{@id},#{val[0]},'no',#{serviceId},'sending',#{locId[0]},#{userId},'nil')"
        begin 
          #Insrting the sms message into optinlist table before sent
          sth = @dbh.prepare(sql)
          sth.execute                    
          rescue
        end
        sql="select max(id) from optinlists"
        #getting the last record inserted in the optinlists table
        begin
          sth = @dbh.prepare(sql)
          sth.execute                    
          updateId=1
          while row=sth.fetch do
            updateId=row[0]
          end                    
          updateId=updateId.to_i
          rescue
          return QUERY_ERROR
        end
        #Calling Gateway Here
        begin
          phone=val[0].lstrip.rstrip.to_i
          #Find the message is SMS or WAP
          #If the message is SMS
          if(type=='SMS')
            #Call the DRuby Gateway Server
            begin
              if isAd==true
		puts "The DATA IS #{data}"
                begin
                  @embedAD=EmbedAd.new
                  res=@embedAD.embedAD(phone,data,cid)
                  puts "The Response is #{data=res}"
                rescue Exception=>e
                end
                
              end
              result= @obj.sendMessage(username,password,serviceId,9841272948,phone,data,nil,locId[0])
              rescue Exception =>e
            end
            if result==10
              report="not sent"
            elsif result==0
              report="sent"
            else
              report="not sent"
            end
            #Update the DLR report to optinlists
            sql="update optinlists set approval_message='#{report}' where id=#{updateId}"
            begin
              sth=@dbh.prepare(sql)
              sth.execute
              rescue
              return QUERY_ERROR
            end
            
            #If the message is WAP
          elsif(type=='WAP')
            begin
              #result=obj.sendMessage(username,password,serviceId,9841272948,phone,nil,data)
              result= @obj.sendMessage(username,password,serviceId,9841272948,phone,nil,data,locId[0])
              rescue
              return GATEWAY_ERROR
            end
            if result==10
              report="not sent"
            elsif result==50
              report="Invalid data"
            elsif result==0
              report="sent"
            else
              report="not sent"
            end
            #Update the DLR report to optinlists
            sql="update optinlists set approval_message='#{report}' where id=#{updateId}"
            begin
              sth = @dbh.prepare(sql)
              sth.execute                            
              rescue
              return QUERY_ERROR
            end
          end
          rescue Exception =>e
          #Error handling for Gateway Server
          report="not sent"
          sql="update optinlists set approval_message='#{report}' where id=#{updateId}"
          begin
            sth = @dbh.prepare(sql)
            sth.execute                        
            rescue
            return QUERY_ERROR
          end
        end
        #Gateway end here
      end
    end
  end
  
  
  ################################################################################
  
  #Name: blastMessage
  #Purpose: This method send the bulk sms or wap messages
  #version: 1.0
  #Last modified:
  #To use this method: This method is working as a server
  #Note: This method getting the phone number file from Rails root and this class placed in Rails script folder
  
  def blastMessage(path,username,password,serviceId,userId,fileId,data,type)

    puts "No ads"
    sth=nil
    Thread.new do
      if !@obj
        return GATEWAY_ERROR
      end
      sql="select phone_file from mobileuploads where id=#{fileId}"
      file=''
      begin
        #getting the uploaded file name from database
        sth = @dbh.prepare(sql)
        sth.execute                
        rescue Exception =>e
        return QUERY_ERROR
      end
      if sth.rows>0
        while row=sth.fetch do
          file=row[0]
        end
      else
        return NODATA
      end            
      begin
        #getting the file from rails root folder
        #grtting the file by service id and file name
        @arr=IO.readlines("#{path}/public/mobileupload/phone_file/#{fileId}/#{file}")   
        folderPath="#{path}/public/mobileupload/phone_file/#{fileId}/#{file}"
        #delete the file from rails root after reading the content of the file
        #garbage collection
        File.delete(folderPath)
        
        rescue
        return FILE_ERROR
      end
      
      #converting the file content into array
      @phone=@arr.to_a
      if(@phone.length==0)
        return NODATA
      end
      $phoneLength = @phone.length
      for i in 0...@phone.length
        #Split the phone number by '-' to get the location id and phone number
        locId=@phone[i].split("-")
        val=locId[1].split(",")
        #Add to Database 
        sql="select max(id) from optinlists"
        begin
          sth = @dbh.prepare(sql)
          sth.execute                    
          @id=0
          while row=sth.fetch do
            @id=row[0]
          end                    
          @id=@id.to_i+1
          rescue
          return QUERY_ERROR
        end
        sql="insert into optinlists (id,phone_no,approved,service_id,approval_message,location_code,user_id,response) values (#{@id},#{val[0]},'no',#{serviceId},'sending',#{locId[0]},#{userId},'nil')"
        begin 
          #Insrting the sms message into optinlist table before sent
          sth = @dbh.prepare(sql)
          sth.execute                    
          rescue
        end
        sql="select max(id) from optinlists"
        #getting the last record inserted in the optinlists table
        begin
          sth = @dbh.prepare(sql)
          sth.execute                    
          updateId=1
          while row=sth.fetch do
            updateId=row[0]
          end                    
          updateId=updateId.to_i
          rescue
          return QUERY_ERROR
        end
        begin
          phone=val[0].lstrip.rstrip.to_i
          #Find the message is SMS or WAP
          #If the message is SMS
          if(type=='SMS')
            #Call the DRuby Gateway Server
            begin
              result= @obj.sendMessage(username,password,serviceId,9841272948,phone,data,nil,locId[0])
              rescue Exception =>e
            end
            if result==10
              report="not sent"
            elsif result==0
              report="sent"
            else
              report="not sent"
            end
            #Update the DLR report to optinlists
            sql="update optinlists set approval_message='#{report}' where id=#{updateId}"
            begin
              sth=@dbh.prepare(sql)
              sth.execute
              rescue
              return QUERY_ERROR
            end
            
            #If the message is WAP
          elsif(type=='WAP')
            begin
              result= @obj.sendMessage(username,password,serviceId,9841272948,phone,nil,data,locId[0])
              rescue
              return GATEWAY_ERROR
            end
            if result==10
              report="not sent"
            elsif result==50
              report="Invalid data"
            elsif result==0
              report="sent"
            else
              report="not sent"
            end
            #Update the DLR report to optinlists
            sql="update optinlists set approval_message='#{report}' where id=#{updateId}"
            begin
              sth = @dbh.prepare(sql)
              sth.execute                            
              rescue
              return QUERY_ERROR
            end
          end
          rescue Exception =>e
          #Error handling for Gateway Server
          report="not sent"
          sql="update optinlists set approval_message='#{report}' where id=#{updateId}"
          #Updating the optinlists table 
          begin
            sth = @dbh.prepare(sql)
            sth.execute                        
            rescue
            return QUERY_ERROR
          end
        end
        #Gateway end here
      end
    end
  end
end
#Creating the instance for Blast Server
aServerObject = Blast_Server.new
DRb.start_service('druby://192.168.1.2:9199', aServerObject)
DRb.thread.join # Don't exit just yet!
