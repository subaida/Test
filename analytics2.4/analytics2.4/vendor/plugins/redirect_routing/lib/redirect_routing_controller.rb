class RedirectRoutingController < ActionController::Base
  def redirect
    redirect_to params[:url_options]
  end
  def method_missing(action)
  redirect_to params[:url_options].merge({ :action => action })
end
end