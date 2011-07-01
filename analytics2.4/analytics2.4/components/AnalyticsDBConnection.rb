
=begin
 * ZDc.rb
 *
 * Author :  Sathish Kumar Sadhasivam
 * Version:  1.0.0
 * Created:  26 Dec 08
 * Last Modified: 26 Dec 08
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
 *Notes: This module is used to set the global values for database configuration for ZestADZ Database
 *Version: 0.1
 *Note:  
=end
#-------------------------------------------------------------------------------------------------------------------#

    #Name: AnalyticsDBConnection
    #Purpose: This module is used to initialize the database connectivity for ZestADZ Analytics components receiver class
    #version: 0.1
    #Last modified: 26 Dec 08
    #To use this method: It is used access the databse throughout receiver class
    
#module AnalyticsDBConnection
    #Setting the host name where the database resides
    HOSTNAME="192.168.0.15"
    #Setting the database username 
    USERNAME="root"
    #Setting the database password
    PASSWORD="mysql"
    #Setting the database name
    DATABASE="zestadz_analytics"
#end
