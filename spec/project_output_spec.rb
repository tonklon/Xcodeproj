require File.expand_path('../spec_helper', __FILE__)

module ProjectSpecs
  describe Xcodeproj::Project do

    describe "Formatting pbxproj output" do

      before do
        @project = Xcodeproj::Project.new(fixture_path("Sample Project/Cocoa Application.xcodeproj"))
      end

      it "output an encoding preamble" do
        @project.to_pbxproj.should.include "// !$*UTF8*$!\n"
      end

      it "output the archive version" do
        @project.to_pbxproj.should.include "archiveVersion = 1;"
      end

      it "output the classes" do
        @project.to_pbxproj.should.include "\tclasses = {\n\t};"
      end

      it "output the object version" do
        @project.to_pbxproj.should.include "objectVersion = 45;"
      end

      it "output the root object" do
        @project.to_pbxproj.should.include "rootObject = E525238316245A900012E2BA /* Project object */;"
      end

      it "output all object groups" do
        output = @project.to_pbxproj
        output.should.include "/* Begin PBXAggregateTarget section */"
        output.should.include "/* End PBXAggregateTarget section */"
        output.should.include "/* Begin PBXBuildFile section */"
        output.should.include "/* End PBXBuildFile section */"
        output.should.include "/* Begin PBXBuildRule section */"
        output.should.include "/* End PBXBuildRule section */"
        output.should.include "/* Begin PBXContainerItemProxy section */"
        output.should.include "/* End PBXContainerItemProxy section */"
        output.should.include "/* Begin PBXCopyFilesBuildPhase section */"
        output.should.include "/* End PBXCopyFilesBuildPhase section */"
        output.should.include "/* Begin PBXFileReference section */"
        output.should.include "/* End PBXFileReference section */"
        output.should.include "/* Begin PBXFrameworksBuildPhase section */"
        output.should.include "/* End PBXFrameworksBuildPhase section */"
        output.should.include "/* Begin PBXGroup section */"
        output.should.include "/* End PBXGroup section */"
        output.should.include "/* Begin PBXHeadersBuildPhase section */"
        output.should.include "/* End PBXHeadersBuildPhase section */"
        output.should.include "/* Begin PBXLegacyTarget section */"
        output.should.include "/* End PBXLegacyTarget section */"
        output.should.include "/* Begin PBXNativeTarget section */"
        output.should.include "/* End PBXNativeTarget section */"
        output.should.include "/* Begin PBXProject section */"
        output.should.include "/* End PBXProject section */"
        output.should.include "/* Begin PBXReferenceProxy section */"
        output.should.include "/* End PBXReferenceProxy section */"
        output.should.include "/* Begin PBXResourcesBuildPhase section */"
        output.should.include "/* End PBXResourcesBuildPhase section */"
        output.should.include "/* Begin PBXRezBuildPhase section */"
        output.should.include "/* End PBXRezBuildPhase section */"
        output.should.include "/* Begin PBXShellScriptBuildPhase section */"
        output.should.include "/* End PBXShellScriptBuildPhase section */"
        output.should.include "/* Begin PBXSourcesBuildPhase section */"
        output.should.include "/* End PBXSourcesBuildPhase section */"
        output.should.include "/* Begin PBXTargetDependency section */"
        output.should.include "/* End PBXTargetDependency section */"
        output.should.include "/* Begin PBXVariantGroup section */"
        output.should.include "/* End PBXVariantGroup section */"
        output.should.include "/* Begin XCBuildConfiguration section */"
        output.should.include "/* End XCBuildConfiguration section */"
        output.should.include "/* Begin XCConfigurationList section */"
        output.should.include "/* End XCConfigurationList section */"
        output.should.include "/* Begin XCVersionGroup section */"
        output.should.include "/* End XCVersionGroup section */"
      end

      it "output the object groups in alphabetical order" do
        output = @project.to_pbxproj
        output.index('/* Begin PBXAggregateTarget section */').should < output.index('/* Begin PBXBuildFile section */')
        output.index('/* End PBXBuildFile section */').should < output.index('/* End PBXBuildRule section */')
        output.index('/* End PBXLegacyTarget section */').should < output.index('/* Begin PBXNativeTarget section */')
        output.index('/* End PBXSourcesBuildPhase section */').should < output.index('/* Begin PBXTargetDependency section */')
        output.index('/* End XCConfigurationList section */').should < output.index('/* Begin XCVersionGroup section */')
      end

      it "output PBXAggregateTarget objects" do
        @project.to_pbxproj.should.include "E550D6AA16371AF600A003E9"
      end

      it "output PBXBuildFile objects" do
        @project.to_pbxproj.should.include "E525239116245A900012E2BA"
        @project.to_pbxproj.should.include "E525239B16245A900012E2BA"
        @project.to_pbxproj.should.include "E525239D16245A900012E2BA"
        @project.to_pbxproj.should.include "E550D84B16371BD000A003E9"
        @project.to_pbxproj.should.include "E5FBB2D116357C16009E96B0"
      end

      it "output PBXBuildFile objects in alphabetical order" do
        output = @project.to_pbxproj
        output.index('E525239116245A900012E2BA').should < output.index('E525239B16245A900012E2BA')
        output.index('E525239B16245A900012E2BA').should < output.index('E525239D16245A900012E2BA')
        output.index('E525239D16245A900012E2BA').should < output.index('E550D84B16371BD000A003E9')
        output.index('E550D84B16371BD000A003E9').should < output.index('E5FBB2D116357C16009E96B0')
      end

      it "output XCVersionGroup objects" do
        @project.to_pbxproj.should.include "E52523AB16245A910012E2BA"
        @project.to_pbxproj.should.include "E525241116245AB20012E2BA"
        @project.to_pbxproj.should.include "E5D464AB163578AC006A4730"
        @project.to_pbxproj.should.include "E5D464AE163578C7006A4730"
        @project.to_pbxproj.should.include "E5D464B216357954006A4730"
      end

      it "output XCVersionGroup objects in alphabetical order" do
        output = @project.to_pbxproj
        output.index('E52523AB16245A910012E2BA').should < output.index('E525241116245AB20012E2BA')
        output.index('E525241116245AB20012E2BA').should < output.index('E5D464AB163578AC006A4730')
        output.index('E5D464AB163578AC006A4730').should < output.index('E5D464AE163578C7006A4730')
        output.index('E5D464AE163578C7006A4730').should < output.index('E5D464B216357954006A4730')
      end

    end

  end
end