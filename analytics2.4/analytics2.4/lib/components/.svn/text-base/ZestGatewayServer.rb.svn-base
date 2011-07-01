
=begin
 * GatewayServer.rb
 *
 * Author :  P.S.Mohamed Hussain
 * Version:  1.0.0
 * Created:  11/03/07
 * Last Modified: 07/06/07
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
 *Notes: This gateway server sends the sms or wap messages to end users ,It validates the phone numbers and sends the sms or wap messages
 *Version: 0.1
 *Note:  
=end
#-------------------------------------------------------------------------------------------------------------------#
require 'dbi'
require 'net/http'
require 'drb'


#Name: GatewayServer class
#Purpose: this class is used to send the SMS or WAP messages
#version: 1.0
#Last modified: 22/05/07
#To use this method: 
class GatewayServer
    #Creating the  log file to store the error when occured
    SUCCESS=0
    EXTERNAL_ERROR=10
    AUTHENTICATION_ERROR=11
    DATABASE_ERROR=12
    INVALID_NUMBER=13
    ACCESS_ERROR=14
	HOSTNAME="192.168.1.4"
	USERNAME="root"
	PASSWORD="sqlworx@ch"
	DATABASE="DBI:MYSQL:zestadz_development:192.168.1.4"
    #print "INFO : Gateway server before starting"
    print "INFO : Gateway server starting."
    sleep(1)
    print "."
    sleep(1)
    print ".\n"
    sleep(1)
    print "INFO : Gateway server running port :: "
    sleep(2) 
    print "2882\n"
    report=nil
    print "INFO : Connecting database server."
    sleep(1)
    print "."
    sleep(1)
    print "."
    sleep(1)
    def initialize
        begin
            #Connecting the database server
            #@db = Mysql.real_connect(HOSTNAME,USERNAME,PASSWORD,DATABASE) 
            @dbh = DBI.connect(DATABASE,USERNAME,PASSWORD)
            report="Connected"
            @debug=true
            print "#{report}\n"
            puts "INFO : GatewayServer :: Server started"
        rescue Exception =>e
            #If any occur to connecting the database server then the error stored in log file and return error message
            #return "PANIC: Gatewayserver :: DataBase not connecting..it may not be running or the password may be wrong.."
            report="Database is not connected,contact your development team"
            puts "\nERROR : GatewayServer :: #{report} #{e.to_s}"
            
        end
        
    end
    
    sleep(2)
    #-------------------------------------------------------------------------------------
    #Name: sendMessage
    #Purpose: this method is used to send SMS or WAP message
    #version: 1.0
    #Last modified: 22/05/07
    #To use this method: This mehtod is working as a server created by DRuby
    #-------------------------------------------------------------------------------------
    
    #Thread starts
	
    Thread.new do   
        def sendMessage(username,password,serviceId,from,toPhone,msg,wapUrl,code) #Method for send SMS message or Wap to user
            #checking the message is nil or not
            #If it is not nil then do the gsub i.e concatinating the message in spaces
            if msg!=nil
                if msg.split('%20').size >0
                    msg=msg.gsub('%20',' ')
                else
                    msg=msg.gsub(' ','%20')
                end
            end
            #Variable for finding the message is WAP or SMS
            @type="0"
            
            to=toPhone.to_s 
            from=from.to_s
            #Validating the from and to phone numbers
            if to.size==10  and (from.size>=10 or from.size==4)
                toPhone=toPhone
            else
                #return "WARNING : GatewayServer :: Source or Destination Number may wrong"
                puts "GatewayServer : WARNING :: Source or Destination Number may wrong"
                return INVALID_NUMBER
            end
            
            #checking ,if there is wap url present or not
            if wapUrl==nil
                @type="1"
            else
                @type="0"
            end
            
            #ccode='91'
            url=''
            result=''
            carrierName=''
            carrierId=0
            params=''
            gatewayId=0
            
            #Query String for authenticating the user
            sql="select * from users where username='#{username}' and password='#{password}'"
            
            begin
                #Converting the phone number into string data ,to find the size
                ph=from.to_s
                #validating Phone Number
                if ph.size>=10 or ph.size==4                  
                    begin 
                        #Executing the query
                        #res=@db.query(sql) 
                        sth = @dbh.prepare(sql)
                        sth.execute
                        #If there is no user in databse
                        if sth.rows==0    
                            puts "PANIC : GatewayServer :: Internal authentication failed. If you see this message, please contact your sysadmin" if @debug
                            #return "PANIC : GatewayServer :: Internal authentication failed. If you see this message, please contact your sysadmin"
                            return AUTHENTICATION_ERROR
                        end
                    rescue Exception =>e
                        #Throwing Database Connection Error"
                        puts "PANIC : Gatewayserver :: Database is not getting connected..please contact your system administrator"+e.to_s
                        @dbh.disconnect
                        @dbh = DBI.connect(DATABASE,USERNAME,PASSWORD)
                        puts "Database Reconnected now"
                        begin 
                            sth = @dbh.prepare(sql)
                            sth.execute
                        rescue
                            puts "PANIC : Gatewayserver :: Database is not getting connected..please contact your system administrator"+e.to_s
                            return DATABASE_ERROR
                        end
                        #If there is no user in databse
                        if sth.rows==0    
                            puts "PANIC : GatewayServer :: Internal authentication failed. If you see this message, please contact your sysadmin" if @debug
                            #return "PANIC : GatewayServer :: Internal authentication failed. If you see this message, please contact your sysadmin"
                            return AUTHENTICATION_ERROR
                        end
                        #return "PANIC : Gatewayserver :: Database is not getting connected..please contact your system administrator"
                        #return DATABASE_ERROR
                    end 
                    
                    begin 
                        #If there is user in database
                        if sth.rows >0
                            #Check the length of the phone number
                            #gettign the date
                            date=Date.today
                            #Check the phone nmmber
                            if ph.size >=10
                                #find the carrier id to split the phone number and get the first five number of phone number
                                carrierId=ph.to_i/100000
                                carrier=carrierId     
                            else
                                #if the number is short code then assign the number to carrier
                                carrier=from
                            end
                            #query string for finding the gateway by first five numbers
                            sql="select * from gateways where startingphonecode=#{carrier}"   #getting carrier by first five number from phone number
                            begin
                                #Execute the query for getting the carrier name ,url,and parameter
                                sth = @dbh.prepare(sql)
                                sth.execute
                                if sth.rows >0                          
                                    
                                        while row=sth.fetch do
                                                  #getting the Url for particular carrier and carrier name for particular carrier  and Attributes of particular gateway Url
                                                  gatewayId=row[0]
                                                  carrierName=row[1]
                                                  url=row[5]
                                        end
                                    
                                    #res.each { |row| gatewayId=row[0] 
                                     #   carrierName=row[1] 
                                        #getting the Url for particular carrier and carrier name for particular carrier  and Attributes of particular gateway Url
                                     #   url=row[5]   
                                     #   params=row[7]
                                    #}               
                                    
                                    #splitting the parameters 
                                    params=params.split(';')
                                    
                                    #query string for finding the carrier Id using carrier Name
                                    sql="select * from carriers where carrier_name='#{carrierName}'"  #getting carrier Id by carrier Name
                                    begin 
                                        #Execute the query
                                        #res=db.query(sql)
                                        sth = @dbh.prepare(sql)
                                        sth.execute
                                       
                                        #getting carrier Id for carrier name
                                        #res.each { |row|   carrierId=row[0]}               
                                        
                                    rescue
                                        puts "INFO : GatewayServer :: No suitable gateway found, Did you forget to configure it in the Database?"
                                        return "INFO : Gateway Server :: No suitable gateway was found. Please contact the system administrator"
                                        
                                    end
                                    
                                    #checking the carrierId for setting the gateways and send the messages
                                    case gatewayId
                                        #Calling Reliance gateway
                                    when "9"
                                        #Checking the message type
                                        #if it is 1 then it is ordinary sms message or it is wap message
                                        if @type=="1"
                                            #Sending SMS Messages
                                            #Save the sms or wap messages to the outbox table
                                            saveOutbox(toPhone,date,carrierId,msg,gatewayId,serviceId,nil)
                                            begin
                                                result= Net::HTTP.post_form(URI.parse(url),{'username'=>'asghar','password'=>'asghar','to'=>toPhone,'udh'=>'%06%05%04%0B%84%23%F0','text'=>msg})      #Posting data to SMS Gateway using Reliance Gateway
                                                return SUCCESS
                                            rescue    
                                                puts "ERROR : Error in sending message in Reliance gateway ,Please contact System Admin"
                                                return EXTERNAL_ERROR
                                            end
                                        else
                                            #calling Reliance gateway
                                            #if it is 1 then it is ordinary sms message or it is wap message
                                            #Sending WAP Messages
                                            #Save the sms or wap messages to the outbox table
                                            saveOutbox(toPhone,date,carrierId,nil,gatewayId,serviceId,wapUrl)     
                                            begin
                                                result= Net::HTTP.post_form(URI.parse(url),{'username'=>'asghar','password'=>'asghar','to'=>toPhone,'udh'=>'%06%05%04%0B%84%23%F0','text'=>wapUrl})      #Posting data to SMS Gateway using Reliance Gateway
                                                return SUCCESS
                                            rescue    
                                                puts "ERROR : Error in sending message in Reliance gateway ,Please contact System Admin"
                                                return EXTERNAL_ERROR
                                            end
                                        end
                                        
                                    when "8"
                                        #Calling Shortcode gateways
                                        #if it is 1 then it is ordinary sms message or it is wap message
                                        if @type=="1"
                                            #Sending SMS Messages
                                            #Save the sms or wap messages to the outbox table
                                            saveOutbox(toPhone,date,carrierId,msg,gatewayId,serviceId,nil)
                                            begin
                                                result= Net::HTTP.post_form(URI.parse(url),{'user'=>'pshussain','password'=>'hussain','sender'=>'hussain','text'=>msg,'PhoneNumber'=>toPhone})      #Posting data to SMS Gateway using Reliance Gateway
                                                return SUCCESS
                                            rescue
                                                puts "ERROR : Error in sending message in Shortcode gateway ,Please contact System Admin"
                                                return EXTERNAL_ERROR
                                            end
                                        else  
                                            #Calling Shortcode gateways
                                            #if it is 1 then it is ordinary sms message or it is wap message                                    
                                            #Sending WAP Messages
                                            #Save the sms or wap messages to the outbox table
                                            saveOutbox(toPhone,date,carrierId,nil,gatewayId,serviceId,wapUrl)
                                            begin
                                                result= Net::HTTP.post_form(URI.parse(url),{'user'=>'pshussain','password'=>'hussain','sender'=>'hussain','text'=>msg,'PhoneNumber'=>toPhone,'wapUrl'=>wapUrl})      #Posting data to SMS Gateway using Reliance Gateway
                                                return SUCCESS
                                            rescue
                                                puts "ERROR : Error in sending message in Shortcode gateway ,Please contact System Admin"
                                                #return "ERROR : Error in sending message in Shortcode gateway ,Please contact System Admin"
                                                return EXTERNAL_ERROR
                                            end
                                        end
                                    end
                                    
                                else
                                    #Calling default gateway
                                    #sql="select * from gateways where carrier='Default'"   #getting carrier by first five number from phone number
                                    sql="select * from gateways where carrier='Default'"
                                    begin
                                        sth=@dbh.prepare(sql)
                                        sth.execute
                                        #res=@db.query(sql) 
                                    rescue
                                        puts"gatewayServer : ERROR :: Database could not open the gateways table"
                                        return DATABASE_ERROR
                                    end
                                    gatewayId=0
                                    while row=sth.fetch do
                                        carrierName=row[1] 
                                        url=row[5]   
                                        params=row[7]
                                        gatewayId=row[0].to_i
                                    end
                                    #res.each { |row|
                                     #   carrierName=row[1] 
                                      #  url=row[5]   
                                      #  params=row[7]
                                      #  gatewayId=row[0].to_i
                                    #}
                                    params=params.split(';')
                                    
                                    #Query string for getting the carrier Id by carrier Name
                                    sql="select * from carriers where carrier_name='#{carrierName}'"  
                                    begin 
                                        #executing the query
                                        #res=@db.query(sql)
                                        sth=@dbh.prepare(sql)
                                        sth.execute
                                        while row=sth.fetch do
                                            carrierId=row[0]
                                        end
                                        #res.each { |row|  
                                        #    carrierId=row[0]
                                        #}               #setting carrier Id for carrier name
                                        
                                    rescue Exception =>e
                                        puts "gatewayServer : ERROR :: Database could not open the gateways table"+e.to_s
                                        #return "PANIC : Gateway Server :: No suitable carrier was found. Please contact the system administrator"
                                        return DATABASE_ERROR
                                    end
                                    #Checking ,If there is a wap Url
                                    
                                    if @type=="1"
                                        #Save the sms or wap messages to the outbox table
                                        
                                        begin
                                            toPhone=toPhone.to_s
                                            code=code.to_s
                                            toPhone=code.concat(toPhone)
                                            saveOutbox(toPhone,date,carrierId,msg,gatewayId,serviceId,nil)
                                        rescue=>e
                                            puts "GatewayServer : PANIC :: Error in saving message in outbox table #{e.to_s}"
                                        end
                                        begin
                                            if msg.split(' ').size>0
                                                #msg=msg.gsub(' ','%20')
                                            end
                                            #Default Mode
                                            result= Net::HTTP.post_form(URI.parse(url),{'username'=>'360tech','password'=>'tech123','origin_addr'=>'','type'=>0,'message'=>msg,'mobileno'=>toPhone})        #Posting data to SMS Gateway using Reliance Gateway
                                            #Development Mode
                                            #result=Net::HTTP.post_form(URI.parse(url),{'msg'=>msg,'phoneNo'=>toPhone,'CCode'=>code})
                                            #puts "Sent"
                                            puts "GATEWAY SERVER :: #{result.msg}"
                                            return SUCCESS
                                        rescue Exception=>e
                                            puts "ERROR : Error in sending message in Default gateway ,Please contact System Admin"+e.to_s
                                            return EXTERNAL_ERROR
                                        end
                                    else
                                        puts "GatewayServer : WARNING :: You cannot send WAP message through this gateway"if @debug
                                        #return "GatewayServer : WARNING :: Wap message cannot send by this gateway"
                                        return ACCESS_ERROR
                                    end
                                    
                                end
                            rescue
                                puts "GatewayServer : ERROR :: Database could not open the gateways table"
                                #return "GatewayServe : ERROR :: No gateway info in database"
                                return DATABASE_ERROR
                            end
                        else
                            puts "PANIC : GatewayServer :: Invalid carrier Id ,contact Administrator"
                            return "PANIC : Contact your administrator for your carrier id"
                            #Store the error in log file
                        end  
                    rescue
                        puts "INFO : GatewayServer :: Cannot access undefined variable"
                        return "INFO : Undefined variable accessed"
                    end
                else
                    puts "gatewayServer : INFO :: Invalid source and destination numbers"
                    return INVALID_NUMBER
                end
            rescue
                puts "ERROR : GatewayServer :: General error occur in Sending Message"
                return "Error occur in Sending Message"
            end
            
            
        end
    #thread ends     
    end
   



#---------------------------------------------------------------------------------
#Name: saveOutbox
#Purpose: this method is used to store the SMS or WAP messages in outbox table
#version: 1.0
#Last modified: 22/05/07
#To use this method: This mehtod is working as a server created by DRuby
#This method is private,we cannot access from anywhere
#---------------------------------------------------------------------------------
    private
    def saveOutbox(phone,date,carrierId,message,gatewayId,serviceId,url)
        #Checking the message type
        #If the message is WAP
        if message==nil
            #Store thr url in message variable
            message=url
        end
        #I f the message is SMS  
        if url==nil
            #Store the message in message variable
            message=message
        end
        #statement to insert the sms data in database
        tim=Time.new
        time_d=tim.strftime('%X')
        sql="select max(id) from smsoutboxes"
        begin
            sth = @dbh.prepare(sql)
            sth.execute
        rescue
            puts "ERROR :Gateway server :: Save query is not execeuting properly, Check database" if @debug
        end
        @id=0
        while row=sth.fetch do
              @id=row[0]
        end
        @id=@id+1
        @id=@id.to_i
	message=message.to_s
        sql="insert into smsoutboxes(id,message,msisdn,shortcode,cost,service_id,date_delivered,time_delivered,gateway_id) values(#{@id},'#{message}','#{phone}','0','1',#{serviceId},'#{date}','#{time_d}','#{gatewayId}')"
        begin 
            #storing the Received Messages in Database  
            sth = @dbh.prepare(sql)
            sth.execute
        rescue  
            @dbh.disconnect		
	    @dbh = DBI.connect(DATABASE,USERNAME,PASSWORD)
	    sth=@dbh.prepare(sql)
	    sth.execute
            puts "PANIC : Databse could not open the record set to store the message in smsoutboxes"
        end      
    end    
    
    
#end of class    
end

#Creating the instance for GatewayServer
begin
	a=GatewayServer.new
    #staring the GatewayServer
    DRb.start_service('druby://:2882',a)
    #puts"This is not 2882"   	
    DRb.thread.join
rescue Exception=>e
	puts "Exception #{e.to_s}"
    puts "ERROR : GatewayServer :: Server cannot starting...Contact System Administrator "+e.to_s
end
