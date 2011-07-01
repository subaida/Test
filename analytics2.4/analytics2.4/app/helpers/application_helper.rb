# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def encrypt(id)
        begin
            @aes = AESSecurity.new()
            @aes.encrypt(session[:key],session[:iv],"#{id}")
        rescue Exception => e
            puts "ERROR :: ApplicationHelper/encrypt :: #{e.to_s}"
        end
    end

    def pagination_links_remote(paginator, page_options={}, ajax_options={}, html_options={})
      pagination_links_each(paginator, page_options) {|page|
      ajax_options[:url].merge!({:page => page})
      link_to_remote(page, ajax_options, html_options)}
    end
    
end

  
