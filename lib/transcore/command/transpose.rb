module Transcore
  module Command
    module Transpose
      NEXT_TONE = {
        "A"=>"A#",
        "A#"=>"B",
        "B"=>"C",
        "C"=>"C#",
        "C#"=>"D",
        "D"=>"D#",
        "D#"=>"E",
        "E"=>"F",
        "F"=>"F#",
        "F#"=>"G",
        "G"=>"G#",
        "G#"=>"A"
      }
      
      def self.parse_opts(argv)
        return {}
      end
      
      def self.run(argv, input_stream=$stdin, output_stream=$stdout)
        params = self.parse_opts(argv)
        step = (argv.shift || 1).to_i
        input = input_stream.read
        # input.tr!("Ａ-Ｇ", "A-G")
        input.gsub!(/　/, "  ")
        input.gsub!(/ +$/, "")
        input.gsub!(/(^|\s|\/|on)([ACDFG])＃/, "\\1\\2#")
        # input.gsub!(/([ABDEG])b/, "\\1♭")
        input.gsub!(/(^|\s|\/|on)A♭/, "\\1G#")
        input.gsub!(/(^|\s|\/|on)B♭/, "\\1A#")
        input.gsub!(/(^|\s|\/|on)D♭/, "\\1C#")
        input.gsub!(/(^|\s|\/|on)E♭/, "\\1D#")
        input.gsub!(/(^|\s|\/|on)G♭/, "\\1F#")
        step %= 12
        rest = input
        step.times do |i|
          next_str = ""
          while /(^|\s|\/|on)(A#|A|B|C#|C|D#|D|E|F#|F|G#|G)([^\s]*)/ =~ rest
            next_str += $` + $1
            match_str = $2
            post_str = $3
            rest = $'
            next_str += NEXT_TONE[match_str] + post_str
          end
          rest = next_str + rest
        end
        result = rest
        
        output_stream.puts result
        return 0
      end
    end
  end
end