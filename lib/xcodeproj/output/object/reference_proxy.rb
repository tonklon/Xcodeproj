module Xcodeproj
  class Project
    module Object


      class PBXReferenceProxy < AbstractObject

        def reference_comment
          path || "PBXReferenceProxy"
        end

      end
    end
  end
end
