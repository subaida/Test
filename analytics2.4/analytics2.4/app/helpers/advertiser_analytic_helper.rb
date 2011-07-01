module AdvertiserAnalyticHelper
  def encrypt(id)
        begin
            @aes = AESSecurity.new()
            @aes.encrypt(session[:key],session[:iv],"#{id}")
        rescue Exception => e
            puts "ERROR :: ApplicationHelper/encrypt :: #{e.to_s}"
        end
    end
end
