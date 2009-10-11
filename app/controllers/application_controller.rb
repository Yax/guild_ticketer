# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter :correct_safari_and_ie_accept_headers

  def set_filters
    @filters = { 'all' => 'inactive', 'pending' => 'inactive', 'opened' => 'inactive', 'closed' => 'inactive' }
  end
  
  # TODO: create it using hash created in environments.rb
  def set_types
    @types = Hash.new
    @types[''] = '';
    Category.all.each { |cat| @types[cat.name] = cat.id.to_s }
  end

  def correct_safari_and_ie_accept_headers
    request.accepts.sort!{ |x, y| y.to_s == 'text/javascript' ? 1 : -1 } if request.xhr?
  end
  
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
