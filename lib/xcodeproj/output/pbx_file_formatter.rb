module Xcodeproj

  # Helper class to manage output to pbxproj formatted files.
  # The pbxproj file format is basically an NextStep ASCII formatted property list containing a keyed archive of the
  # projects object graph. But is has a lot of comments and nice indentation to make it better readable and diffable.
  # This class works as a kind of visitor that is passed through the projects object graph, so that all objects can
  # add their representations to this formatter for formatting.
  #
  class PBXFileFormatter

    attr_reader :indentation_level

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
  end
end