module Xcodeproj

  class Project
    def to_pbxproj
      pbxproj = "// !$*UTF8*$!\n"
      pbxproj << "{\n"
      pbxproj << "\tarchiveVersion = #{archive_version};\n"
    end
  end

end
