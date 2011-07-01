require File.dirname(__FILE__) + '/test_helper'

class EventsController < ActionController::Base
  def rescue_action(e) raise e end
end

class RedirectRoutingTest < Test::Unit::TestCase

  def setup
    @controller = RedirectRoutingController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_redirect_routes
    with_routing do |set|
      set.draw do |map| 
        map.redirect('', :controller => 'events')
        map.redirect('test', 'http://pinds.com')
      end
      
      assert_recognizes({ :controller => "redirect_routing", :action => "redirect", :url_options => { "controller" => "events" } }, "/")
      assert_recognizes({ :controller => "redirect_routing", :action => "redirect", :url_options => "http://pinds.com" }, "/test")
    end
  end
  
  def test_redirect_controller_with_hash
    get :redirect, :url_options => { :controller => "events" }
    assert_redirected_to :controller => "events"
  end
  
  def test_redirect_controller_with_string
    get :redirect, :url_options => "http://pinds.com"
    assert_redirected_to "http://pinds.com"
  end
end
