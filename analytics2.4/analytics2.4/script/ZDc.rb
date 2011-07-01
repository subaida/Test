
=begin
 * ZDc.rb
 *
 * Author :  P.S.Mohamed Hussain
 * Version:  1.0.0
 * Created:  4/06/07
 * Last Modified: 5/06/07
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

    #Name: ZDc
    #Purpose: This module is used to initialize the database connectivity for ZestADZ receiver class
    #version: 0.1
    #Last modified: 05/06/07
    #To use this method: It is used access the databse throughout receiver class
    
module ZDc
    #Setting the host name where the database resides
    #HOSTNAME="mw22"
    #Setting the database username 
    USERNAME="root"
    #Setting the database password
    PASSWORD="admin"
    #Setting the database name
    DATABASE="DBI:MYSQL:zestadz_analytics_loadtest:localhost"
end
