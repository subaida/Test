=begin
  debug class
  Author :  AsifAli
  Version:  1.0
  Created:  Feb 2007
  Last Modified: Feb 2007
 
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
  
  Version : 1.0
  Note    : This is the debug class

=end


class Debug
    @mode = true 
    @controller = ""
    
    #Method Name: setDebugMode.. takes boolean as parameter
    #Purpose: To send passwords to the users using action mailer
    #Version: 1.0
    #Author: Asif Ali
    #Last Modified: 
    #Notes: None    
    def setDebugMode (m, c)
        begin
            #puts "now in debug rb file :::::#{c} and the mode is #{m}"
            if ((m==true) || (m==false))
                @mode=m
                @controller = c
            end
        rescue Exception=>e
            #puts "DebugClass: ERROR: Failed to set debug mode. Did you pass a wrong datatype..I am expecting a boolean: "+e.to_s
            #no need to route anywhere as this is not a rails controller or a class
            #return false        
        end
      end
    
    def setMode(m)
        @mode = m
    end
      
    def setController(c)
        @controller = c
    end
    
    def putsInfo (action, message)
        puts "INFO :: #{@controller} :: #{action} :: #{message}" if @mode
    end
    
    def putsError (action, message)
        puts "ERROR :: #{@controller} :: #{action} :: #{message}" if @mode
    end
    
    def putsCriticalError (action, message)
        puts "CRITICAL ERROR :: #{@controller} :: #{action} :: #{message}" if @mode
    end
    
    
    def putsDebug (action, message)
        puts "DEBUG :: #{@controller} :: #{action} :: #{message}" if @mode
    end
   
   def putsWarning(action,message)
        puts "WARNING :: #{@controller} :: #{action} :: #{message}" if @mode
     end
   
end

