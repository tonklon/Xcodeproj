module Xcodeproj
  class Project
    module Object

      class AbstractTarget < AbstractObject

        def reference_comment
          name
        end

      end

    end
  end
end
