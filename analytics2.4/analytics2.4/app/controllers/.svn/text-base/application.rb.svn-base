# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
#gem 'recaptcha'
class ApplicationController < ActionController::Base
  #  include ReCaptcha::AppHelper
  #Pick a unique cookie name to distinguish our session data from others'
  include ExceptionNotifiable
  consider_local "61.17.191.15", "192.168.1.88"
  session :session_key => '_HandlerRails_session_id'
  
  #---------------session expiry---------
    around_filter :authorize, :except=> [:login, :memberauthen,:advertiser_update_chart,:advertiser_update_text,:updateChart,:showTextReport,:dashboard_move,:admin_campaign_performance,:admin_advertiser_performance,:admin_publisher_performance,:owner_popup]
  private
 def authorize
      @aes = AESSecurity.new()
      if session[:analytics_expiry]<=Time.now
          reset_session
          flash[:notice]= "Your session has expired. Please login again."
          redirect_to(:controller => "login", :action => "login")
        end unless session[:analytics_expiry].nil?
    yield
    session[:analytics_expiry]= 20.minute.from_now
  end
  #----------------session expiry end--------  
  protected
  exception_data :additional_data
  
  def additional_data
    { :document => @document,
      :person => @person }
  end
  
  def paginate_by_sql(model, sql, per_page, options={})
    if options[:count]
      if options[:count].is_a? Integer
        total = options[:count]
      else
        total = model.count_by_sql(options[:count])
      end
    else
      total = model.count_by_sql_wrapping_select_query(sql)
    end
    
    object_pages = Paginator.new self, total, per_page, params['page']
    #objects = model.find_by_sql_with_limit(sql,object_pages.current.to_sql[1], per_page)
    objects = model.find_by_sql(sql + " limit #{per_page} " +"offset #{object_pages.current.to_sql[1]}")
    return [object_pages, objects]
  end
  
  def rescue_404
    rescue_action_in_public CustomNotFoundError.new
  end
  
  #def rescue_action_in_public(exception)
    #case exception
    #when CustomNotFoundError, ::ActionController::UnknownAction then
      ##render_with_layout "shared/error404", 404, "standard"
      #render :template => "shared/error404", :layout => "standard", :status => "404"
    #else
     # @message = exception
      #render :template => "shared/error", :layout => "standard", :status => "500"
    #end
 # end
  
  def local_request?
    return false
  end
  
  # Paginates an existing AR result set, returning the Paginator and collection slice.
  #
  # Based upon:
  # http://www.bigbold.com/snippets/posts/show/389
  #
  # Options:
  # +:collection+: the collection to paginate
  # +:per_page+: records per page
  # +:page+: page
  #
  # Example:
  #   complex_query_result = Customer.find_by_sql('something complex')
  #   @pages, @customers = paginate_collection(:collection => complex_query_result)
  # 
  # Alternatively, you can specify a block, the result of which will be used as the collection:
  #   @pages, @customers = paginate_collection { Customer.find_by_sql('something complex') }
  def paginate_collection(options = {}, &block)
    if block_given?
      options[:collection] = block.call
    elsif !options.include?(:collection)
      raise ArgumentError, 'You must pass a collection in the options or using a block'
    end
    
    default_options = {:per_page => 10, :page => 1}
    options = default_options.merge options
    
    pages = Paginator.new self, options[:collection].size, options[:per_page], options[:page]
    first = pages.current.offset
    last = [first + options[:per_page], options[:collection].size].min
    slice = options[:collection][first...last]
    return [pages, slice]
  end
  
  

  def putsInfo (controller, action, message)
    puts "INFO :: #{controller} :: #{action} :: #{message}" if DEBUG
  end
  
  def putsError (controller, action, message)
    puts "ERROR :: #{controller} :: #{action} :: #{message}" if DEBUG
  end
  
  def putsCriticalError (controller, action, message)
    puts "CRITICAL ERROR :: #{controller} :: #{action} :: #{message}" if DEBUG
  end
  
  
  def putsDebug (controller, action, message)
    puts "DEBUG :: #{controller} :: #{action} :: #{message}" if DEBUG
  end
  
  def putsWarning(controller, action,message)
    puts "WARNING :: #{controller} :: #{action} :: #{message}" if DEBUG
  end
  
  
end

module ActiveRecord
  class Base
    def self.find_by_sql_with_limit(sql, offset, limit)
      sql = sanitize_sql(sql)
      add_limit!(sql, {:limit => limit, :offset => offset})
      find_by_sql(sql)
    end
    
    def self.count_by_sql_wrapping_select_query(sql)
      sql = sanitize_sql(sql)
      count_by_sql("select count(*) from (#{sql}) as my_table")
    end
  end
end
