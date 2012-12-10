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

    it "adds lines without indentation" do
      @formatter.indent
      @formatter.add_unindented_line "Foo"
      @formatter.lines.should.include "Foo"
    end

  end

  describe "add key value pairs" do
    it "adds an key value pair with string value" do
      @formatter.add_value_for_key "Foo", "Bar"
      @formatter.lines.should.include "Bar = Foo;"
    end

    it "adds an key value pair with hash value" do
      @formatter.add_value_for_key ({"Foo" => "FooBar"}), "Bar"
      @formatter.lines.should.include "Bar = {"
      @formatter.lines.should.include "\tFoo = FooBar;"
      @formatter.lines.should.include "};"
    end

    it "sorts added hashes by key" do
      @formatter.add_value_for_key ({"B" => "Foo","D" => "Bar","C" => "Foo", "A" => "Bar"}), "Bar"
      @formatter.lines.should.include "Bar = {"
      @formatter.lines.index("\tA = Bar;").should < @formatter.lines.index("\tB = Foo;")
      @formatter.lines.index("\tB = Foo;").should < @formatter.lines.index("\tC = Foo;")
      @formatter.lines.index("\tC = Foo;").should < @formatter.lines.index("\tD = Bar;")
      @formatter.lines.should.include "};"
    end

    it "adds an key value pair with empty hash value" do
      @formatter.add_value_for_key Hash.new, "Bar"
      @formatter.lines.should.include "Bar = {"
      @formatter.lines.should.include "};"
    end

    it "adds an key value pair with array value" do
      @formatter.add_value_for_key (["Foo", "Bar"]), "Bar"
      @formatter.lines.should.include "Bar = ("
      @formatter.lines.should.include "\tFoo,"
      @formatter.lines.should.include "\tBar,"
      @formatter.lines.should.include ");"
    end

    it "adds an key value pair with an object reference" do
      class TestObjectReference
        def uuid
          "1234"
        end
        def reference_comment
          "comment"
        end
      end

      @formatter.add_value_for_key TestObjectReference.new, "Key"
      @formatter.lines.should.include "Key = 1234 /* comment */;"
    end

    it "doesn't add an key value pair with nil value" do
      @formatter.add_value_for_key nil, "Bar"
      @formatter.lines.size.should == 0
    end

    it "quotes string values containing whitespace" do
      @formatter.add_value_for_key "Foo Bar", "Foo"
      @formatter.lines.should.include "Foo = \"Foo Bar\";"
    end

    it "quotes string values containing <square brackets>" do
      @formatter.add_value_for_key "Foo<Bar", "Foo"
      @formatter.add_value_for_key "Foo>Bar", "Foo"
      @formatter.lines.should.include "Foo = \"Foo<Bar\";"
      @formatter.lines.should.include "Foo = \"Foo>Bar\";"
    end

    it "quotes string values containing (round braces)" do
      @formatter.add_value_for_key "Foo(Bar", "Foo"
      @formatter.add_value_for_key "Foo)Bar", "Foo"
      @formatter.lines.should.include "Foo = \"Foo(Bar\";"
      @formatter.lines.should.include "Foo = \"Foo)Bar\";"
    end

    it "quotes string values containing {curly braces}" do
      @formatter.add_value_for_key "Foo{Bar", "Foo"
      @formatter.add_value_for_key "Foo}Bar", "Foo"
      @formatter.lines.should.include "Foo = \"Foo{Bar\";"
      @formatter.lines.should.include "Foo = \"Foo}Bar\";"
    end

    it "quotes empty strings" do
      @formatter.add_value_for_key "", "Foo"
      @formatter.lines.should.include "Foo = \"\";"
    end

    it "does not quote strings containing dots. underscores_ and slashes/" do
      @formatter.add_value_for_key "._/", "Foo"
      @formatter.lines.should.include "Foo = ._/;"
    end

    it "escapes multiple newlines" do
      @formatter.add_value_for_key "Foo\nBar\n", "Foo"
      @formatter.lines.should.include "Foo = \"Foo\\nBar\\n\";"
    end

    it "escapes newlines followed by something" do
      @formatter.add_value_for_key "Foo\nBar", "Foo"
      @formatter.lines.should.include "Foo = \"Foo\\nBar\";"
    end

    # This is rather weird, but it's the way Xcode is doing it as far as my tests go.
    it "does not escape the only newline if it is the end of the string" do
      @formatter.add_value_for_key "Foo\n", "Foo"
      @formatter.lines.should.include "Foo = \"Foo\n\";"
    end

    it "escapes quotes" do
      @formatter.add_value_for_key "\"", "Foo"
      @formatter.lines.should.include "Foo = \"\\\"\";"
    end

  end

  describe "output" do
    it "returns string output" do
      @formatter.formatted_file.should == ""
    end

    it "returns an added line" do
      @formatter << "Foo"
      @formatter.formatted_file.should == "Foo"
    end

    it "returns several lines separated with newlines" do
      @formatter << "Foo"
      @formatter << "Bar"
      @formatter.formatted_file.should == "Foo\nBar"
    end

    it "does not include a newline for the last line" do
      @formatter << "1"
      @formatter << "2"
      @formatter.formatted_file.should.include "1\n"
      @formatter.formatted_file.should.not.include "2\n"
    end
  end

  describe "validations" do
    it "can be validated" do
      @formatter.should.be.valid
    end

    it "is invalid with nonzero indentation level" do
      @formatter.indent
      @formatter.should.not.be.valid
      @formatter.unindent
      @formatter.should.be.valid
    end

    it "raises when trying to output invalid content" do
      @formatter.indent
      lambda {
        @formatter.formatted_file
      }.should.raise
    end
  end

end
