# coding: utf-8
module Transcore
  module Command
    module Convert
      def self.parse_opts(argv)
        return {}
      end
      
      def self.run(argv, input_stream=$stdin, output_stream=$stdout)
        params = self.parse_opts(argv)
        command = argv.shift
        input = input_stream.read
        
        input.gsub!(/　/, "  ")
        
        case command
        when "sharp"
          input.gsub!(/(^|\s|\/|on)A♭/, "\\1G#")
          input.gsub!(/(^|\s|\/|on)B♭/, "\\1A#")
          input.gsub!(/(^|\s|\/|on)D♭/, "\\1C#")
          input.gsub!(/(^|\s|\/|on)E♭/, "\\1D#")
          input.gsub!(/(^|\s|\/|on)G♭/, "\\1F#")
        when "flat"
          input.gsub!(/(^|\s|\/|on)G#/, "\\1A♭")
          input.gsub!(/(^|\s|\/|on)A#/, "\\1B♭")
          input.gsub!(/(^|\s|\/|on)C#/, "\\1D♭")
          input.gsub!(/(^|\s|\/|on)D#/, "\\1E♭")
          input.gsub!(/(^|\s|\/|on)F#/, "\\1G♭")
        when "doremi"
          input.gsub!(/A/, "ラ")
          input.gsub!(/B/, "シ")
          input.gsub!(/C/, "ド")
          input.gsub!(/D/, "レ")
          input.gsub!(/E/, "ミ")
          input.gsub!(/F/, "ファ")
          input.gsub!(/G/, "ソ")
        when "text-score"
          input.gsub!(/\n/, "")
          input.gsub!(/<br\/?>/, "\n")
          input.gsub!(/<\/p>/, "\n")
          input.gsub!(/<[^>]+>/, " ")
          input.gsub!(/&nbsp;/, " ")
          input.gsub!(/　/, "  ")
          input.gsub!(/^ +/, "")
          input.gsub!(/ +$/, "")
          input.gsub!(/／/, "|")
          input.gsub!(/＃/, "#")
          input.gsub!(/   /, "  ")
          input.gsub!(/\n\n\n/, "\n\n")
        end
        result = input
        
        output_stream.puts result
        return 0
      end
    end
  end
end