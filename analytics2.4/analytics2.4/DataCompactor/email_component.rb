require 'rubygems'
require 'net/smtp'
require 'tlsmail'
#Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)

class SendMail < Net::SMTP
    def initialize(options)
      super
        @server   = "smtp.illian.net"
        @from     = "zestadz.com"
        @user     = "support@zestadz.com"
        @pass     = "test321"
        @to     = options["to"]
        @subject  = options["subject"]
      end
      def body=(mail_body)
        # BUILD HEADERS
        @body =  "From: #{@from} <#{@from}>\n" 
        #@body << "To: #{@to}<#{@to}>\n"
        @body << "Subject: #{@subject}\n"
        @body << "Date: #{Time.now}\n"
        @body << "Importance:high\n"
        @body << "MIME-Version:1.0\n"
        @body << "content-type:text/html \n"
        @body << "\n\n\n"
        # MESSAGE BODY
        @body << mail_body
      end
      def send
        begin
          Net::SMTP.start(@server,25,@from,nil,nil,:plain) do |smtp|
          smtp.send_message(@body,@user,@to)
        end
        rescue Exception=>e
          puts "ERROR :: Error in Mailer #{e.to_s}"
      end
    end
  end


#Net::SMTP.start( server='localhost', port=25, domain=ENV['HOSTNAME'], acct=nil, passwd=nil, authtype=:cram_md5 ) 
 
 
#~ o=Hash.new
#~ o["to"]=["barakath@mobile-worx.com",
             #~ "hussain@mobile-worx.com",
             #~ "barakcse@gmail.com",
             #~ "geetha@mobile-worx.com",
             #~ "s.sathishkumar@mobile-worx.com"
             #~ ]
#~ o["subject"] = "ERROR MESSAGE : From RingRing Component"

#~ mail=SendMail.new(o)
#~ mail.body="ERROR:in ring ring comp please review"
#~ mail.send

  
 
