require 'drb'

=begin
 * Gateway.rb
 *
 * Author :  P.S.Mohamed Hussain
 * Version:  1.0.0
 * Created:  30/05/07
 * Last Modified: 30/05/07
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
 *Notes: This class is used to call the Gateway server and send the message,it is wrapper class 
         for ZestADZ gateway
 *Version: 0.1
 *Note:  
=end
#-------------------------------------------------------------------------------------------------------------------#

    #Name: Gateway wrapper class
    #Purpose: this class is used to send the SMS or WAP messages
    #version: 1.0
    #Last modified: 30/05/07
    #To use this method: We can create and call this class to send a message
class Gateway
    PARAMETER_ERROR=50
    GATEWAY_ERROR=51
    INVALID_NUMBER=52
    #Name: sendMessage
    #Purpose: this method is used to send SMS or WAP message
    #version: 1.0
    #Last modified: 30/05/07
    #To use this method: This mehtod is working as a wrapper class to call this method
  def sendMessage(username,password,serviceId,gatewayPhone,receiverNumber,message,wapUrl)
    debug=false
    #puts "Gateway Class #{username}" 
    
    begin
        #if receiverNumber.class!="Bignum"
        #    return INVALID_NUMBER
        #end
        end
        if message ==nil and wapUrl==nil
            #puts "Gateway : ERROR :: Invalid data sent"
            return PARAMETER_ERROR
        end
        if username==nil or password==nil or gatewayPhone==nil or receiverNumber==nil
            #puts "Gateway : ERROR :: Invalid data sent"
            return PARAMETER_ERROR
        end
        #puts "username  #{username}" if debug
        #puts "password #{password}" if debug
        #puts "service #{serviceId}" if debug
        #puts "Gateway #{gatewayPhone}" if debug
        #puts "phone #{receiverNumber}" if debug
        #puts "message #{message}" if debug
        #puts "Url is #{wapUrl}" if debug
        
        #creating an instance for the gateway DRuby server
        #It will run under the port 2882
        
        obj=DRbObject.new(nil,'druby://localhost:2882')
        #Call the DRuby gateway server method 
        
          ##puts "In for loop #{phone}"
          val= obj.sendMessage(username,password,serviceId,gatewayPhone,receiverNumber,message,wapUrl)
          return val
        

    rescue Exception => e
        #puts"Gateway server is not running  from class" 
        return GATEWAY_ERROR
        #system("ruby","ZestGatewayServer.rb")
    end
  
end

