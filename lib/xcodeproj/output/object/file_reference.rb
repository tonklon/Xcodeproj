module Xcodeproj
  class Project
    module Object

      class PBXFileReference < AbstractObject

        def reference_comment
          name || path
        end

        def output_to_formatter (formatter)
          comment = reference_comment.nil? ? "" : " /* #{reference_comment} */"
          formatter.add_line "#{uuid}#{comment} = {isa = #{isa}; #{attribute_representation(formatter) }};"
        end

        def attribute_representation (formatter)
          representation = ""
          self.class.attributes.sort {|a,b| a.plist_name <=> b.plist_name}.each do |attribute|
            if attribute.type == :simple
              representation << "#{attribute.plist_name} = #{formatter.quoted_string attribute.get_value(self)}; " unless attribute.get_value(self).nil?
            end
          end
          representation
        end

      end
    end
  end
end
