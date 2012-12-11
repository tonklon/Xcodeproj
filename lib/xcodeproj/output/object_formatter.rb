require 'xcodeproj/project/object'

module Xcodeproj
  class Project
    module Object
      class AbstractObject

        def reference_comment
          nil
        end

        def output_to_formatter (formatter)
          comment = reference_comment.nil? ? "" : " /* #{reference_comment} */"
          formatter.add_line "#{uuid}#{comment} = {"
          formatter.indent
          output_attributes_to_formatter formatter
          formatter.unindent
          formatter.add_line "};"
        end

        def output_attributes_to_formatter (formatter)
          formatter.add_value_for_key self.isa, "isa"
          self.class.attributes.sort {|a,b| a.plist_name <=> b.plist_name}.each do |attribute|
            output_attribute_to_formatter attribute, formatter
          end
        end

        def output_attribute_to_formatter (attribute, formatter)
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
            when :references_by_keys
              formatter.add_value_for_key attribute.get_value(self).to_a, attribute.plist_name
          end
        end

      end
    end
  end
end

require 'xcodeproj/output/object/build_configuration'
require 'xcodeproj/output/object/build_file'
require 'xcodeproj/output/object/build_phase'
require 'xcodeproj/output/object/build_rule'
require 'xcodeproj/output/object/configuration_list'
require 'xcodeproj/output/object/container_item_proxy'
require 'xcodeproj/output/object/file_reference'
require 'xcodeproj/output/object/group'
require 'xcodeproj/output/object/native_target'
require 'xcodeproj/output/object/reference_proxy'
require 'xcodeproj/output/object/root_object'
require 'xcodeproj/output/object/target_dependency'