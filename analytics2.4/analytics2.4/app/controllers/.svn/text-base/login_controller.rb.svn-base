=begin

  login_controller.rb
  Author :  Asghar Ali
  Version:  1.0
  Created:  Feb 2007
  Last Modified: Feb 2007
  Last modified by :  Sathish Kumar
 
  Copyright (c) 2006-2007 by CalChennai Mobile-worx  Pvt Ltd
 
  All rights reserved.
 
  1059 Opal Way, Gardena, CA 90247 
 
  Y222, 2nd Floor, 2nd Avenue, Anna Nagar, Chennai 600040
  www.mobile-worx.com
 
  INTELLECTUAL PROPERTY RIGHTS NOTICE
  ALL IPR including that of source code, design documents, algorithms, flow documents,project plans,
  reviews, images,architectural documents and other documents related to this document are held by
  mobile-worx and any modification, alteration,re-engineering, reverse engineering or
  any change targeted towards any kinds of use would be severely dealt with under the Federal Laws
  of United States of America & Republic of India

  Contact us at info@mobile-worx.com
  Name: Login controller
  Version : 1.0
  Note    : To authenticate end users

=end
require 'ezcrypto'
require 'aes_security.rb' #this is to require AES security component
class LoginController < ApplicationController

  #caches_page :login
  ADVERTISER=2
  ADMIN=1
  PUBLISHER=3
  SUCCESS = 0
  def index
      begin
        session[:userName]=nil if session[:userName]=='demo'
          render :layout => false
      rescue Exception=>e
          puts"The Error is :: #{e.to_s}"
      end
  end
  
  
  #Method Name: memberauth
  #Purpose: To authenticate users
  #Version: 1.0
  #Author: Asghar Ali
  #Last Modified: Md Shujauddeen
  #Notes: None
  def memberauthen
    begin
        @aes = AESSecurity.new()
        session[:key] = nil
        session[:iv] = nil
        session[:user_id] = nil
        reset_session
        if params['SIGNIN']
            username= params[:user]['username']
            password=params[:user]['password']
            if ((username==nil or username.strip=="") or (password==nil or password.strip==""))
                flash[:notice]="Username or password cannot be blank."
                @loginError=true
                render :action => "index",:layout=>false
            else
                verifyDBconnection
                @userData=User.find_by_username(username)
                if @userData==nil
                    flash[:notice]="No such user exists."
                    @loginError=true
                    render :controller=>'login',:action => "index",:layout=>false
                else
                    if @userData.password==password
                        if @userData.status=="Active"
                          	if (@userData.access_on_analytics=="true" || @userData.access_on_analytics=="filled")
                                  #this is to creae adv / pub acc if not exists
                                  publisherDetails=Publisher.find_by_user_id(@userData.id.to_i)
                                  advertiserDetails=Advertiser.find_by_user_id(@userData.id.to_i)
                                  if publisherDetails==nil
                                       @publishers = Publisher.new     
                                       @publishers.user_id=@userData.id.to_i
                                       @publishers.save
                                  end
                                  if advertiserDetails==nil
                                      @advertisers = Advertiser.new     
                                      @advertisers.user_id=@userData.id.to_i
                                      @advertisers.save
                                      @advertiseraccounts = Advertiseraccount.new     
                                      @advertiseraccounts.user_id=@userData.id.to_i
                                      @advertiseraccounts.advertiser_id=@advertisers.id.to_i
                                      @advertiseraccounts.save
                                  end
                                  if @userData.role_id==5
                                      @loginError=false
                                      if @userData.key!=nil && @userData.key!="" && @userData.iv!=nil && @userData.key!=""
                                          @aes.generateKey("#{@userData.username}#{@userData.id}#{@userData.password}")
                                          @userData.key = @aes.key.to_s
                                          @userData.iv = @aes.iv.to_s
                                          @userData.update
                                      end
                                      session[:key] = @userData.key
                                      session[:iv] = @userData.iv
                                      session[:user_id] = @aes.encrypt(session[:key],session[:iv],"#{@userData.id}")
                                      session[:userName]=username
                                      redirect_to :controller=>'home'
                                  elsif @userData.role_id==1
                                      @loginError=false
                                       if @userData.key!=nil && @userData.key!="" && @userData.iv!=nil && @userData.key!=""
                                          @aes.generateKey("#{@userData.username}#{@userData.id}#{@userData.password}")
                                          @userData.key = @aes.key.to_s
                                          @userData.iv = @aes.iv.to_s
                                          @userData.update
                                      end
                                      session[:key] = @userData.key
                                      session[:iv] = @userData.iv
                                      session[:user_id] = @aes.encrypt(session[:key],session[:iv],"#{@userData.id}")
                                      session[:userName]=username
                                     	redirect_to :controller=>'admin_analytic',:action=>'admin_home'
                                  else
                                      @loginError=true
                                      flash[:notice]="Your account has not been activated yet."
                                      render :controller=>'login',:action => "index",:layout=>false  
                                  end
                            else
                                 @loginError=true
                                 flash[:notice]="Your account has not been approved."
                                 render :controller=>'login',:action => "index",:layout=>false     
                            end
                        else
                            flash[:notice]="Your account has not been activated yet."
                            @loginError=true
                            render :controller=>'login',:action => "index",:layout=>false     
                        end
                    else
                        flash[:notice]="Invalid username or password."
                        @loginError=true
                        render :controller=>'login',:action => "index",:layout=>false     
                    end
                end
            end
        elsif params['cancel']
            redirect_to :controller=>'login', :action=>'index'
        end   
    rescue Exception=>e
        puts "ERROR :: Login / memberauthen :: #{e.to_s}"
        #~ flash[:notice]="An error occured while you are trying to login."
        flash[:notice]="#{e.to_s}"
        render :action => "index",:layout=>false
    end
end


  #Method Name: memberauth
  #Purpose: To authenticate users
  #Version: 1.0
  #Author: Asghar Ali
  #Last Modified: 05-June-2007 by Asif Ali
  #Notes: None
  def demoaccount
      begin
         @aes = AESSecurity.new()
          username= params[:demo] 
          verifyDBconnection
          @userData=User.find_by_username(username)
          session[:key] = @userData.key
          session[:iv] = @userData.iv
          session[:user_id] = @aes.encrypt(session[:key],session[:iv],"#{@userData.id}")
          session[:userName]=username
          redirect_to :controller=>'home'
      rescue Exception=>e
          puts "Exception in Login #{e.to_s}"
          flash[:notice]="An error occured while you are trying to login."
          render :action => "index", :layout => false
      end
 end
  
  #Method Name: Login
  #Purpose: To check for the user within the database
  #Version: 1.0
  #Author: Asghar Ali
  #Last Modified: 02-July-2009 by Md Shujauddeen
  #Notes: None
  def login
    begin
     session[:user_id]=nil 
     session[:userName]=nil
        render :action=>"index",:layout=>false        
    rescue Exception=>e
      render :layout=>true    
    end
    
  end
  
  #Method Name: logout
  #Purpose: To logout users
  #Version: 1.0
  #Author: Asghar Ali
  #Last Modified: 02-June-2007 by Asif Ali
  #Notes: None
  def logout
    begin
	
      cookies.delete :theAccountName 
      cookies.delete :thePassword   
      #it deletes all the session variables related to this particular user
      session[:key]=nil
      session[:iv]=nil
      session[:userName]=nil
      session[:errorText]=nil
      session[:linkHighlight]=nil
      session[:link_check]=nil
      session[:temp_link]=nil 
      session[:order]=nil
      session[:record]=nil
      session[:user_id]=nil
      session[:campaign_name]=nil 
      session[:max_budget]=nil
      session[:price]=nil
      session[:user_id]=nil 
      session[:securityToken]=nil
      session[:advreport_camp_id]=nil
      session[:advreport_ad_id]=nil
      session[:advreport_start_on]=nil
      session[:advreport_end_on]=nil
      session[:duration]=nil
      session[:page]=nil
      session[:advxml_string]=nil
      session[:advxml_array]=nil
      session[:report_adclient]=nil
      session[:report_start_on]=nil
      session[:report_end_on]=nil
      session[:duration]=nil
      session[:xml_string]=nil
      session[:xml_array]=nil
      session[:adminstart_on]=nil
      session[:adminend_on]=nil
      session[:adv_id]=nil
      session[:pub_id]=nil
      session[:adv_continent_info]=nil
      session[:continent_info]=nil
      session[:getPub_id]=nil
      session[:pub_name]=nil
     session[:adv_name]=nil
     session[:limit]=nil
     reset_session
      	render :action => "index",:layout => false          #and it moves to the login page
      rescue Exception=>e
      	render :action => "index", :layout => false          #and it moves to the login page
    end
  end
  
  #Method Name: forgotpwd 
  #Purpose: a dummy action for the view
  #Version: 1.0
  #Author: Asghar Ali
  #Last Modified: 02-June-2007 by Asif Ali
  #Notes: None
  def forgetpwd
   render :layout=>false
  end
  
  #Method Name: sendpwd
  #Purpose: To send passwords to the users using action mailer
  #Version: 1.0
  #Author: Asghar Ali
  #Last Modified: 02-June-2007 by Asif Ali
  #Notes: None
  def request_access
  #begin 
        flash[:message]=nil
        flash[:notice]=nil
        if params[:SIGNIN]=='Send'
          if params[:user]['email'] !=nil && params[:user]['email'] !=""
              if params[:user]['email']=~/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i 
                  email=params[:user]['email']
                  verifyDBconnection
                  @userData = User.find_by_email(email)                          #finds the user name and password for email
                  if @userData == nil
                      session[:errorText] = "Sorry, User not found!"
                      render :controller=>'login', :action=>'request_access'       #if email is not present in the database then it moves to the forgot password page
                  elsif (@userData.access_on_analytics=='true' || @userData.access_on_analytics=="filled")
                      session[:errorText] = "Your account has already been approved"
                      render :controller=>'login', :action=>'request_access'  
                  elsif @userData.access_on_analytics=='false'
                      mail = Emailcomponent.create_requestaccess(@userData)                #if the email is present in the database then it mails the user name and password to the user
                      mail.set_content_type("text/html")                                          #email address
                      Emailcomponent.deliver(mail)
                      #render(:text=> "<pre>"+mail.encoded+"</pre>")
                      session[:errorText]=nil
                      flash[:message]="&nbsp;Your request has been sent to the administrator. Please be patient to get the access"
                      render :controller=>'login', :action=>'request_access' 
                  end
              else
                  flash[:notice]="Please enter a valid email-id."
                  render :controller=>"login",:action => "request_access"
              end
          else
                flash[:notice]="Please enter an email-id."
                render :controller=>"login",:action => "request_access"
          end
      end
  end
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	#Method Name: home_analytics
	#Purpose: to render home page
	#Version: 1.0
	#Author: Md Shujauddeen A
	#Last Modified: 20-Oct-2008 by Md Shujauddeen A
	#Notes: None
	#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    def verifyDBconnection
        check_DBstatus=ActiveRecord::Base.connection.active?
        if check_DBstatus==true
        else
               ActiveRecord::Base.connection.reconnect!
        end
    end
end
