require "xcodeproj/output/pbx_file_formatter"

module Xcodeproj

  class Project
    def to_pbxproj
      formatter = Xcodeproj::PBXFileFormatter.new
      formatter << "// !$*UTF8*$!"
      formatter << "{"
      formatter.indent
      formatter.add_value_for_key archive_version, "archiveVersion"
      formatter.add_value_for_key classes, "classes"
      formatter.add_value_for_key object_version, "objectVersion"

      add_objects_to_formatter formatter

      formatter.add_value_for_key root_object, "rootObject"
      formatter.unindent
      formatter.formatted_file
    end

    def add_objects_to_formatter (formatter)
      objects_by_isa.keys.sort.each do |isa_group|
        formatter.add_unindented_line "/* Begin #{isa_group} section */"
        formatter.add_unindented_line "/* End #{isa_group} section */"
      end
    end

    def objects_by_isa
      objects.group_by { |object| object.isa}
    end

  end

end
