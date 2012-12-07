require File.expand_path('../spec_helper', __FILE__)

module ProjectSpecs
  describe Xcodeproj::Project do

    describe "Formatting pbxproj output" do
      it "output an encoding preamble" do
        @project.to_pbxproj.should.include "// !$*UTF8*$!\n"
      end

      it "output the archive version" do
        @project.to_pbxproj.should.include "archiveVersion = 1;"
      end
    end

  end
end