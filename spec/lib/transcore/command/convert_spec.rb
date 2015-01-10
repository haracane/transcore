# coding: utf-8
require 'spec_helper'

describe Transcore::Command::Convert do
  describe '.run(argv, input_stream, output_stream)' do
    context "when argv = 'flat'" do
      context "when input = 'F Dm A# C'" do
        it "should output 'F Dm B♭ C'" do
          input = 'F Dm A# C'
          input_read, input_write = *IO.pipe
          output_read, output_write = *IO.pipe
          input_write.puts input
          input_write.close
          Transcore::Command::Convert.run(['flat'], input_read, output_write)
          output_write.close
          result = output_read.read
          result.chomp.should eq 'F Dm B♭ C'
        end
      end
    end

    context "when argv = 'sharp'" do
      context "when input = 'F Dm B♭ C'" do
        it "should output 'F Dm A# C'" do
          input = 'F Dm B♭ C'
          input_read, input_write = *IO.pipe
          output_read, output_write = *IO.pipe
          input_write.puts input
          input_write.close
          Transcore::Command::Convert.run(['sharp'], input_read, output_write)
          output_write.close
          result = output_read.read
          result.chomp.should eq 'F Dm A# C'
        end
      end
    end

    context "when argv = 'doremi'" do
      context "when input = 'CDEFGAB'" do
        it "should output 'ドレミファソラシド'" do
          input = 'CDEFGAB'
          input_read, input_write = *IO.pipe
          output_read, output_write = *IO.pipe
          input_write.puts input
          input_write.close
          Transcore::Command::Convert.run(['doremi'], input_read, output_write)
          output_write.close
          result = output_read.read
          result.chomp.should eq 'ドレミファソラシ'
        end
      end
    end

    context "when argv = 'text-score'" do
      context 'when input is inline-chord html' do
        it 'should output inline-chord score' do
          input = <<-EOF
<p>
<span class="chord">C</span><span class="word">word1</span><span>Am</span><span>word2</span>
</p>
<p>
<span>word3</span><span>F</span><span>word4</span><span>G7</span><span>word5</span>
</p>
          EOF
          input_read, input_write = *IO.pipe
          output_read, output_write = *IO.pipe
          input_write.puts input
          input_write.close
          Transcore::Command::Convert.run(['text-score'], input_read, output_write)
          output_write.close
          result = output_read.read
          # STDERR.puts result
          result = result.split(/\r?\n/)
          # result.each do |line| STDERR.puts line.inspect end
          result.shift.should eq 'C  word1  Am  word2'
          result.shift.should eq 'word3  F  word4  G7  word5'
          result.size.should eq 0
        end
      end
    end

    context "when argv = 'text-score'" do
      context 'when input is super-chord html' do
        it 'should output super-chord score' do
          input = <<-EOF
<p><span>C</span></p>
<p>word1</p>
<p><span>Am&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F&nbsp;G7</span></p>
<p>word2&nbsp;word3&nbsp;word4</p>
          EOF
          input_read, input_write = *IO.pipe
          output_read, output_write = *IO.pipe
          input_write.puts input
          input_write.close
          Transcore::Command::Convert.run(['text-score'], input_read, output_write)
          output_write.close
          result = output_read.read
          # STDERR.puts result
          result = result.split(/\r?\n/)
          # result.each do |line| STDERR.puts line.inspect end
          result.shift.should eq 'C'
          result.shift.should eq 'word1'
          result.shift.should eq 'Am     F G7'
          result.shift.should eq 'word2 word3 word4'
          result.size.should eq 0
        end
      end
    end

  end
end
