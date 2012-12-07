require 'xcodeproj/project/object'

module Xcodeproj
  class Project
    module Object
      class AbstractObject

        def reference_comment
          nil
        end

        def output_to_formatter (formatter)
          formatter.add_line "#{uuid} = {"
          formatter.indent
          output_attributes_to_formatter formatter
          formatter.unindent
          formatter.add_line "};"
        end

        def output_attributes_to_formatter (formatter)
          formatter.add_value_for_key self.isa, "isa"
          self.class.attributes.sort {|a,b| a.plist_name <=> b.plist_name}.each do |attribute|
            case attribute.type
              when :simple
                formatter.add_value_for_key attribute.get_value(self), attribute.plist_name
              when :to_one
                formatter.add_value_for_key attribute.get_value(self), attribute.plist_name
              when :to_many
                formatter.add_line "#{attribute.plist_name} = ("
                formatter.indent
                attribute.get_value(self).each do |object|
                  comment = object.reference_comment.nil? ? "" : " /* #{object.reference_comment} */"
                  formatter.add_line "#{object.uuid}#{comment},"
                end
                formatter.unindent
                formatter.add_line ");"
            end
          end
        end

      end
    end
  end
end

require 'xcodeproj/output/object/root_object'