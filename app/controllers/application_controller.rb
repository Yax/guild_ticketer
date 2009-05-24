# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end

#Monkeypatching for colorful logs on windows
module ActiveRecord
  module ConnectionAdapters
    class AbstractAdapter
      protected
        def format_log_entry(message, dump = nil)
        if ActiveRecord::Base.colorize_logging
          if @@row_even
            @@row_even = false
            message_color, dump_color = "0;31;1", "0;1"
          else
            @@row_even = true
            message_color, dump_color = "0;32;1", "0;2"
          end
      
          log_entry = "  \e[#{message_color}m#{message}\e[0m   "
          log_entry << "\e[#{dump_color}m%#{String === dump ? 's' : 'p'}\e[0m" % dump if dump
          log_entry
        else
          "%s  %s" % [message, dump]
        end
      end
    end
  end
end
