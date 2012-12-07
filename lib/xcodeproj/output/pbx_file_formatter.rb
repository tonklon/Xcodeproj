require 'xcodeproj/output/object_formatter'

module Xcodeproj

  # Helper class to manage output to pbxproj formatted files.
  # The pbxproj file format is basically an NextStep ASCII formatted property list containing a keyed archive of the
  # projects object graph. But is has a lot of comments and nice indentation to make it better readable and diffable.
  # This class works as a kind of visitor that is passed through the projects object graph, so that all objects can
  # add their representations to this formatter for formatting.
  #
  class PBXFileFormatter

    attr_reader :indentation_level
    attr_reader :lines

    def initialize
      @lines = Array.new
      @indentation_level = 0
    end

    def indent
      @indentation_level += 1
    end

    def unindent
      raise "Can not decrement below 0" if @indentation_level == 0
      @indentation_level -= 1
    end

    def add_line (line)
      @lines << "#{"\t" * @indentation_level}#{line}"
    end

    def add_value_for_key (value, key)
      if (value.is_a?(String))
        add_string_value_for_key value, key
        return
      end
      if (value.is_a?(Hash))
        add_hash_value_for_key value, key
        return
      end
      if (value.respond_to?(:reference_comment) && value.respond_to?(:uuid))
        add_string_value_for_key "#{value.uuid} /* #{value.reference_comment} */", key
        return
      end
    end

    def add_string_value_for_key (value, key)
      add_line "#{key} = #{value};"
    end

    def add_hash_value_for_key (value, key)
      add_line "#{key} = {"
      indent
      value.each_pair do |hash_key, hash_value|
        add_value_for_key hash_value, hash_key
      end
      unindent
      add_line "};"
    end

    def << (line)
      add_line line
    end

    def formatted_file
      raise "Can not output invalid content" unless valid?
      @lines.join("\n")
    end

    def valid?
      (@indentation_level == 0)
    end
  end
end