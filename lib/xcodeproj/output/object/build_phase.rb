module Xcodeproj
  class Project
    module Object

      class AbstractBuildPhase < AbstractObject
        def reference_comment
          "Build phase"
        end
      end


      class PBXHeadersBuildPhase < AbstractBuildPhase
        def reference_comment
          "Headers"
        end
      end


      class PBXSourcesBuildPhase < AbstractBuildPhase
        def reference_comment
          "Sources"
        end
      end


      class PBXFrameworksBuildPhase < AbstractBuildPhase
        def reference_comment
          "Frameworks"
        end
      end


      class PBXResourcesBuildPhase < AbstractBuildPhase
        def reference_comment
          "Resources"
        end
      end


      class PBXCopyFilesBuildPhase < AbstractBuildPhase
        def reference_comment
          name || "CopyFiles"
        end
      end


      class PBXShellScriptBuildPhase < AbstractBuildPhase
        def reference_comment
          name || "ShellScript"
        end
      end


      class PBXRezBuildPhase < AbstractBuildPhase
        def reference_comment
          "Rez"
        end
      end
    end
  end
end
