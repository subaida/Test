module RedirectRouting
  module Routes
    def redirect(path, options={})
      connect path, :controller => "redirect_routing", :action => "redirect", :url_options => options
    end
  end
end
