# coding: utf-8
require "spec_helper"

describe Transcore::Command::Transpose do
  describe ".run(argv, input_stream, output_stream)" do
    context "when argv = #{["1"].inspect}" do
      context "when input = #{"C Am F Gm/B".inspect}" do
        it "should output #{"C# A#m F# G#m/C".inspect}" do
          input = "C Am F Gm/B"
          input_read, input_write = *IO.pipe
          output_read, output_write = *IO.pipe
          input_write.puts input
          input_write.close
          Transcore::Command::Transpose.run(["1"], input_read, output_write)
          output_write.close
          result = output_read.read
          result.chomp.should == "C# A#m F# G#m/C"
        end
      end
    end
    
    context "when argv = #{["-1"].inspect}" do
      context "when input = #{"C Am F Gm/B".inspect}" do
        it "should output #{"B G#m E F#m/A#".inspect}" do
          input = "C Am F Gm/B"
          input_read, input_write = *IO.pipe
          output_read, output_write = *IO.pipe
          input_write.puts input
          input_write.close
          Transcore::Command::Transpose.run(["-1"], input_read, output_write)
          output_write.close
          result = output_read.read
          result.chomp.should == "B G#m E F#m/A#"
        end
      end
    end
  end
end
  
