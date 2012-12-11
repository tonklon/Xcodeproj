module Xcodeproj
  class Project
    module Object

      class PBXGroup < AbstractObject

        def reference_comment
          name || path
        end

      end

    end
  end
end
