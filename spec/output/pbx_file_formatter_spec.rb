require File.expand_path('../../spec_helper', __FILE__)
require "xcodeproj/output/pbx_file_formatter"

describe "Xcodeproj::PBXFileFormatter" do

  before do
    @formatter = Xcodeproj::PBXFileFormatter.new
  end

  describe "indentation" do
    it "starts its life with indentation 0" do
      @formatter.indentation_level.should == 0
    end

    it "increases the indentation" do
      @formatter.indent
      @formatter.indentation_level.should == 1
      @formatter.indent
      @formatter.indentation_level.should == 2
    end

    it "decreases the indentation" do
      @formatter.indent
      @formatter.indent
      @formatter.unindent
      @formatter.indentation_level.should == 1
    end

    it "raises when trying to decrease below zero" do
      lambda {
        @formatter.unindent
      }.should.raise
    end
  end

  describe "add lines" do
    it "adds lines" do
      @formatter.add_line "Foo"
      @formatter.lines.size.should == 1
      @formatter.lines.should.include "Foo"
    end

    it "adds lines with << operator" do
      @formatter << "Foo"
      @formatter.lines.should.include "Foo"
    end

    it "adds lines with indentation" do
      @formatter.indent
      @formatter.add_line "Foo"
      @formatter.lines.should.include "\tFoo"
    end
  end

end
