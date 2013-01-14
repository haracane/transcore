require "spec_helper"

describe "bin/transcore" do
  context "when command = transpose" do
    input = "C Am F G7"
    context "when parameter = 1" do
      context "when input is '#{input}'" do
        it "should output #{"C# A#m F# G#7".inspect}" do
          result = `echo '#{input}' | ruby -I lib ./bin/transcore transpose 1`
          result.chomp!
          result.should == "C# A#m F# G#7"
        end
      end
    end
  end

  context "when command = convert" do
    context "when sub-command = flat" do
      input = "F Dm A# C"
      context "when input is '#{input}'" do
        it "should output \"#{"F Dm B♭ C"}\"" do
          result = `echo '#{input}' | ruby -I lib ./bin/transcore convert flat`
          result.chomp!
          result.should == "F Dm B♭ C"
        end
      end
    end
  end
end
