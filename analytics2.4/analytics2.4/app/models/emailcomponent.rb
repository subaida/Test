class Emailcomponent < ActionMailer::Base

  def requestaccess(root)
    @subject        = 'Request for access on ZestADZ analytics'
    @body["root"]  = root
    @recipients     = 'support@zestadz.com'
    @from           = 'analytics@mobile-worx.com'
  end
  
    
end
