require "xcodeproj/output/pbx_file_formatter"

module Xcodeproj

  class Project
    def to_pbxproj
      formatter = Xcodeproj::PBXFileFormatter.new
      formatter << "// !$*UTF8*$!"
      formatter << "{"
      formatter.indent
      formatter.add_value_for_key archive_version, "archiveVersion"
      formatter.unindent
      formatter.formatted_file
    end
  end

end
