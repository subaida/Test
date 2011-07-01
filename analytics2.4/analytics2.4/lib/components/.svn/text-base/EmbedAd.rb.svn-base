require 'net/http'
require 'uri'
require 'drb'
#require 'ZAd.rb'


#name : EmbedAd
#created by : Hussain
#date : 30-10-2007
#note : This class is used to get the token and embed the Ad with 
#       the sms message and return
class EmbedAd
  
  def initialize
  end
  
  #name : embedAD
  #created by : Hussain
  #date : 30-10-2007
  #note : this method gets the input like phone number,message and publisher id,
  #       this method pulls the AD from the database and returns to the controller  
  Thread.new do
    
    def embedAD(phone,message,pub_id)
      begin
        msg_only=""
      	msg_only=message
		msg = ""
        #request for the token
        res=Net::HTTP.post_form(URI.parse('http://www.zestadz.com:9898/smshandler'),{'request'=>pub_id})      
        tok=res.body
        if tok==""
          #request for the token,if the first request failed to get the token
          puts "The token was nil"
          res=Net::HTTP.post_form(URI.parse('http://www.zestadz.com:9898/smshandler'),{'request'=>pub_id})      
          tok=res.body
          puts "The second request for Token is #{tok}"
        end
        rescue Exception=>e
          puts "ERROR :: EmbedAd :: Token is not generated first request"+e.to_s      
          #return ZAd::NOTOKENS
          begin
            res=Net::HTTP.post_form(URI.parse('http://www.zestadz.com:9898/smshandler'),{'request'=>pub_id})      
            tok=res.body
            puts "The third request for Token is #{tok}"
          rescue Exception=>e
            puts "ERROR :: Embed Ad :: Token generation failed in"+e.to_s
            return msg_only
          end
      end  
      
      if tok!=nil
        val = "#{phone}~#{message}~2~#{tok}"
        #Embedding ad with the message
        begin
          res=Net::HTTP.post_form(URI.parse('http://www.zestadz.com:9898/smshandler'),{'request'=>val})      #Posting data to SMS Gateway using Reliance Gateway
        rescue Exception=>e
          puts "ERROR :: embedAD :: AD embedding Failed 1"
          begin
              res=Net::HTTP.post_form(URI.parse('http://www.zestadz.com:9898/smshandler'),{'request'=>val})      #Posting data to SMS Gateway using Reliance Gateway
              puts "The second request for ad is #{res.body}"
          rescue Exception=>e
              puts "ERROR :: embedAD :: AD embedding Failed 1"
              return msg_only
          end
          
        end
        begin
          
          #msg_only=""
          if res.code=='200'
	    	msg = ""
            message=res.body
            message=message.split('~')
            msg=message[1]
          	return msg
          else
            val = "#{phone}~#{message}~2~#{tok}"
            #Embedding ad with the message
            begin
                res=Net::HTTP.post_form(URI.parse('http://www.zestadz.com:9898/smshandler'),{'request'=>val})      #Posting data to SMS Gateway using Reliance Gateway
                puts "The third request for ad is #{res.body}"
            rescue Exception=>e
                puts "ERROR :: embedAD :: AD embedding Failed 1"
                return msg_only
            end
            if res.code=='200' 
		      msg = "" 
              message=res.body
              #msg_only=""
              message=message.split('~')
              msg=message[1]
              return msg
            else
                return msg_only
            end
      	  end
          rescue Exception=>e
            puts "ERROR :: embedAD :: Ad Embedding Failed 2"
            #return ZAd::ADERROR
            return msg_only
        end
      end
    end
  end
end

#a = EmbedAd.new
#for i in 0...50
#	msg = "hello"+i.to_s
#a.embedAD(9884064360, msg, '14131C047A50424A41574556465246408B9A')
#end
