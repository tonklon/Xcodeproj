module Xcodeproj
  class Project
    module Object

      class XCConfigurationList < AbstractObject

        def reference_comment
          if referrers.first.is_a?(Xcodeproj::Project::Object::PBXProject)
            return "Build configuration list for #{referrers.first.isa} \"#{project.project_name}\""
          end
          "Build configuration list for #{referrers.first.isa} \"#{referrers.first.name}\""
        end

      end
    end
  end
end
