module PluginAWeek #:nodoc:
  module CoreExtensions #:nodoc:
    module Date #:nodoc:
      module InterpolatedTimeFormats
        def self.included(base) #:nodoc:
          base.class_eval do
            alias_method_chain :strftime, :interpolation
          end
        end
        
        def strftime_with_interpolation(format = '%F') #:nodoc:
          format = instance_eval("%@#{format.gsub('@', '\@')}@")
          strftime_without_interpolation(format)
        end
      end
    end
    
    module Time #:nodoc:
      # Enables the ability to use interpolated values when specifying the
      # format in strftime.
      # 
      # Examples:
      # 
      #   t = Time.parse('12/31/2006 12:00')
      #   t.strftime('#{month}-#{day}-#{year}')     # => 12-31-2006
      #   t.strftime('on #{month}/#{day}')          # => on 12/31
      #   t.strftime('%a #{month}/#{day}')          # => Sun 12/31
      module InterpolatedTimeFormats
        def self.included(base) #:nodoc:
          base.class_eval do
            alias_method_chain :strftime, :interpolation
          end
        end
        
        def strftime_with_interpolation(format) #:nodoc:
          format = instance_eval("%@#{format.gsub('@', '\@')}@")
          strftime_without_interpolation(format)
        end
        
        # Returns the hour of the day (1..12) for <tt>time</tt>.
        def short_hour
          (hour % 12).nonzero? ? hour % 12 : 12
        end
      end
    end
  end
end

class ::Date #:nodoc:
  include PluginAWeek::CoreExtensions::Date::InterpolatedTimeFormats
end

class ::Time #:nodoc:
  include PluginAWeek::CoreExtensions::Time::InterpolatedTimeFormats
end