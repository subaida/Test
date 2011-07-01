
=begin
 * SecurityComponent.rb
 *
 * Author :  P.S.Mohamed Hussain
 * Version:  1.0.0
 * Created:  3/06/07
 * Last Modified: 4/06/07
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
 *Notes: Security component.rb does the following. generates keys. Authenticate users and generates session tokens. Decrypts and revalidates sessions
 *It also manages role based security for components and pages.
 *Version: 0.2
 *Note:  
=end
#-------------------------------------------------------------------------------------------------------------------#

#require 'dbi'
#require 'ZDc.rb'

require 'rubygems'
require 'active_record'  
class Security
    
    ActiveRecord::Base.establish_connection(  
                                        :adapter => "mysql",  
:host => "mw55",  
:database => "zestadz_development",
:username => "root",
:password => "adminmobile"
)
class Addelivery < ActiveRecord::Base  
end
class User < ActiveRecord::Base  
end
class Adsdelivery < ActiveRecord::Base  
end
GENERAL_FAILURE=-1
		USER_NOT_AUTHENTICATED=-5001
		ENTITY_NOTALLOWED=-5007
		SUCCESS=0
    
    #Name: Initialize
    #Purpose: This method is used to initialize the Database Connection and create a log file
    #version: 1.0
    #Last modified: 04/06/07
    #To use this method: It is used access the databse throughout this class
    def initialize
        begin
            #@dc=DBI.connect('DBI:MYSQL:zestadz_development:localhost', 'zestadz', 'hjtfjkk5454bhh')
            rescue Exception=>e
        end
    end
    
    #Name: generateToken
    #Purpose: Generate a token
    #version: 1.0
    #Last modified: 4/06/07
    #To use this method: This method is used to generate a token for a given user session
    public
    def generateToken(username,password)
        return password
    end
    
    
    #Name: checkSecurity
    #Purpose: Check user and entity security
    #version: 1.0
    #Last modified:04/06/07
    #This method is used to validate users, with their tokens and validate their access to the given entitiy.
    #An entity could be a controller, action, or even a component class 
    #Note: The token is recommended to be stored by the calling client method as a session or within the database
    def checkSecurity(user,token,entity_id)
        #begin
            #Getting the key which is generated when user logged
            #  @@dbconn = DBI.connect("DBI:MYSQL:zestadz_development:mw22", "zestadz", "hjtfjkk555454bhh")
            #check ont the key username and key right now
            #Need to modify this later
            #begin
               puts  sqlMain="select role_id from users where username='#{user}'"
                @user=User.find(:first, :conditions=>["username = '#{user}'"])
                #results=@dc.select_one(sqlMain)
                #puts @user.class
                if @user!=nil
                  puts role_id=@user.role_id
                end
                #rescue Exception=>e
                #@dc.disconnect
                #@dc=nil
                #return USER_NOT_AUTHENTICATED
            #end
	    if role_id==nil
		role_id=-1
	    end
            puts sqlMain="select * from entities where role_id=#{role_id} and id=#{entity_id}"
            @user=User.find_by_sql(sqlMain)
            #affectedRows=@dc.execute(sqlMain)  
            if @user!=nil
                  if @user.size>0 
                       #this means the entity belongs to the given role
                      return SUCCESS
                  else
                  	return ENTITY_NOTALLOWED   
                  end     
              end
           #rescue Exception =>e
            #return GENERAL_FAILURE
           #end
    end
end   
