require File.expand_path('../spec_helper', __FILE__)

module ProjectSpecs
  describe Xcodeproj::Project do

    describe "Formatting pbxproj output" do
      it "output an encoding preamble" do
        @project.to_pbxproj.should.include "// !$*UTF8*$!\n"
      end

    end

  end
end