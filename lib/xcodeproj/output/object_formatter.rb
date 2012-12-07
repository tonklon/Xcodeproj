require 'xcodeproj/project/object'

module Xcodeproj
  class Project
    module Object
      class AbstractObject

        def reference_comment
          "unknown"
        end

      end
    end
  end
end

require 'xcodeproj/output/object/root_object'