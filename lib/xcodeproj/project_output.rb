require "xcodeproj/output/pbx_file_formatter"

module Xcodeproj

  class Project
    def to_pbxproj
      formatter = Xcodeproj::PBXFileFormatter.new
      formatter << "// !$*UTF8*$!"
      formatter << "{"
      formatter.indent
      formatter << "archiveVersion = #{archive_version};"
      formatter.unindent
      formatter.formatted_file
    end
  end

end
