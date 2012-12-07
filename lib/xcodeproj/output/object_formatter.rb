require 'xcodeproj/project/object'

module Xcodeproj
  class Project
    module Object
      class AbstractObject

        def reference_comment
          "unknown"
        end

        def output_to_formatter (formatter)
          formatter.add_line "#{uuid} = {"
          formatter.indent
          formatter.unindent
          formatter.add_line "};"
        end

      end
    end
  end
end

require 'xcodeproj/output/object/root_object'