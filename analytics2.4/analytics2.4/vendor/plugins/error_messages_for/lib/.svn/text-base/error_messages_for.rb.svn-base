module ActionView
  module Helpers
    module ActiveRecordHelper
      def error_messages_for(object_names, options = {})
        defaults = {:priority => [], :attr_names => {}, :defaults => true, :header => ''}
        options = defaults.merge(options).symbolize_keys
        # Convert object name to an array of objects
        object_names = [object_names] unless object_names.class == Array
        objects = []
        object_names.each { |name| objects << instance_variable_get("@#{name}") }

        errors = []
        objects.each { |obj| obj.errors.each { |attr, val| errors << [attr, val] } }

        unless errors.empty?
          unless options[:priority].empty?
            errors.sort! do |a, b|
              if options[:priority].include?(a[0]) and options[:priority].include?(b[0])
                # both columns have priority, compare accordingly
                options[:priority].index(a[0]) <=> options[:priority].index(b[0])
              elsif options[:priority].include?(a[0])
                # column a defined, stick in front of b
                -1
              elsif options[:priority].include?(b[0])
                # column b defined, stick in front of a
                1
              else
                # both columns have equal priority
                0
              end
            end
          end

          # Override the default header and perform substitutions
          options[:header] = (options[:header].empty?) ? "#{pluralize(errors.size, "error")} prohibited this #{object_names[0].to_s.gsub("_", " ")} from being saved" : options[:header].gsub(/\{count\}/, errors.size.to_s).gsub(/\{object\}/, object_names[0])

          content_tag("div",
            content_tag( options[:header_tag] || "h2", options[:header] ) +
            content_tag("p", options[:sub_header] || "There were problems with the following fields:") +
            content_tag("ul", errors.collect { |value| content_tag("li", ((options[:attr_names].has_key?(value[0])) ? "#{options[:attr_names][value[0]]}" + (options[:defaults] ? " #{value[1]}" : '') : "#{value[0].humanize} #{value[1]}")) }),
            "id" => options[:id] || "errorExplanation", "class" => options[:class] || "errorExplanation"
          )
        end
      end
    end
  end
end