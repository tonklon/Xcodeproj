module Xcodeproj
  class Project
    module Object

      class PBXContainerItemProxy < AbstractObject

        def reference_comment
          isa
        end

        def output_attribute_to_formatter (attribute, formatter)
          return super(attribute, formatter) unless attribute.name == :container_portal

          uuid = attribute.get_value(self)
          object = project.objects_by_uuid[uuid]
          formatter.add_string_value_for_key object.uuid, attribute.plist_name, object.reference_comment
        end

      end
    end
  end
end
