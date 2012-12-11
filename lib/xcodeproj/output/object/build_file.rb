module Xcodeproj
  class Project
    module Object

      class PBXBuildFile < AbstractObject

        def reference_comment
          group = referrers.first.display_name.gsub /BuildPhase/,""
          "#{file_ref.display_name} in #{group}"
        end

        def output_to_formatter (formatter)
          comment = reference_comment.nil? ? "" : " /* #{reference_comment} */"
          reference = "#{file_ref.uuid} /* #{file_ref.reference_comment} */"
          formatter.add_line "#{uuid}#{comment} = {isa = #{isa}; fileRef = #{reference}; };"
        end

      end
    end
  end
end
