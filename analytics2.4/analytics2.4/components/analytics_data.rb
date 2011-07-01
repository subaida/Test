#/*
# * admin_analytics_data.rb
# *
# * Author :Shujauddeen and Mangai
# * Version: 1.0
# * Created: 12-10-2010
# * Last Modified: 
# *
# * Copyright (c) 2003-2008 by CalChennai Mobile-worx  Pvt Ltd
# *
# * All rights reserved.
# *
# * 1059 Opal Way, Gardena, CA 90247 
# *
# * Y222, 2nd Floor, 2nd Avenue, Anna Nagar, Chennai 600040
# * www.mobile-worx.com
# *
# * INTELLECTUAL PROPERTY RIGHTS NOTICE
# * ALL IPR including that of source code, design documents, algorithms, flow documents,project plans,
# * reviews, images,architectural documents and other documents related to this document are held by
# * mobile-worx and any modification, alteration,re-engineering, reverse engineering or
# * any change targeted towards any kinds of use would be severely dealt with under the Federal Laws
# *     of United States of America & Republic of India
# *
# * Contact us at
# * info@mobile-worx.com
# *
# * Notes 
# * Version: 0.9.1
# * Functionality: AnalyticsData component is used to hold the publisher,advertiser,adclients name for subsequent request. it helps us to avoid hitting db for all the request 
# */
##
#
#This class is used to set and return advertiser and publisher details.

#--------------------------------------------------------------------------------------------
  #Class Name: AnalyticsData
  #Purpose: Used to hold advertisr,publisher,campaigns and adclients details
  #Version: 1.0
  #Author:Shujauddeen/Mangai
  #Last Modified: 12-oct-2010
  #Notes: None.
#-------------------------------------------------------------------------------------------- .         
class AnalyticsData
    
    #initialze the static/class variable to hold the data b/w diff function call.
    @@adv_data=nil
    @@pub_data=nil
    @@client_data=nil
    @@advertiser_data=nil
    @@expirytime=nil  
      
    #This method is used to set the publisher details.
    def AnalyticsData.publisher_data_set(value)
        begin
            @@pub_data=value
        rescue Exception=>e
            puts"An error occured in publisher_data_set method in AnalyicsData :: #{e}"
        end
    end
    
    #This method is used to set the advertiser details.
    def AnalyticsData.advertiser_data_set(value)
        begin
            @@adv_data= value
        rescue Exception=>e
            puts"An error occured in advertiser_data_set method in AnalyicsData :: #{e}"
        end
    end
    
    #This method is used to return the publisher details.
    def AnalyticsData.publisher_data_get
        begin
	    checkTime()
            @@pub_data
        rescue Exception=>e
            puts"An error occured in publisher_data_get method in AnalyicsData :: #{e}"
        end
    end
        
    
    #This method is used to return the advertiser details.
    def AnalyticsData.advertiser_data_get
        begin
            checkTime()
            @@adv_data
        rescue Exception=>e
            puts"An error occured in advertiser_data_get method in AnalyicsData :: #{e}"
        end
    end
      
    #This method is used to set the advertiser details. 
   def AnalyticsData.advertiser_set(value)
        begin
            @@advertiser_data=value
        rescue Exception=>e
            puts"An error occured in advertiser_set method in AnalyicsData :: #{e}"
        end
   end

   #This method is used to set the adclient details.
   def AnalyticsData.client_set(value)
        begin
            @@client_data=value
        rescue Exception=>e
            puts"An error occured in client_set method in AnalyicsData :: #{e}"
        end
   end      
      
#This method is used to return the advertiser details.
    def AnalyticsData.advertiser_get
	begin
		checkTime()
        	@@advertiser_data
	 rescue Exception=>e
            puts"An error occured in advertiser_get method in AnalyicsData :: #{e}"
        end

      end
#This method is used to return the adclient details.
    def AnalyticsData.client_get
	begin
		checkTime()
	        @@client_data
	rescue Exception=>e
            puts"An error occured in advertiser_get method in AnalyicsData :: #{e}"
        end
    end    
    
    def AnalyticsData.checkTime
        setTime() if @@expirytime==nil or @@expirytime<=Time.now
    end
    
    def AnalyticsData.setTime
        @@expirytime=Time.now+1800
        @@adv_data=nil
        @@pub_data=nil
        @@client_data=nil
        @@advertiser_data=nil
    end
 
end

