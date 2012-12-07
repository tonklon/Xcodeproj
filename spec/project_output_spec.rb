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
    end

  end
end