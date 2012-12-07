module Xcodeproj
  class Command
    class ProjectRewrite < Command
      def self.banner
        %{Reads the project and outputs it again:

    $ project-rewrite source [target]

      If target is not given overwrites source.}
      end

      def initialize(argv)
        @source_path = argv.shift_argument
        @target_path = argv.shift_argument || @source_path
        unless @source_path
          raise Informative, "A source path is required."
        end
        super unless argv.empty?
      end

      def run
        project = Project.new(@source_path)
        File.open(File.join(@target_path,'project.pbxproj'), 'w') {|f| f.write(project.to_pbxproj) }
      end
    end
  end
end
