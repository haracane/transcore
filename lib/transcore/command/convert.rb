module Transcore
  module Command
    module Convert
      def self.parse_opts(_argv)
        {}
      end

      def self.run(argv, input_stream = $stdin, output_stream = $stdout)
        command = argv.shift
        input = input_stream.read

        input.gsub!(/　/, '  ')

        case command
        when 'to-sharp', 'sharp'
          input.gsub!(/(^|\s|\/|on)A♭/, '\\1G#')
          input.gsub!(/(^|\s|\/|on)B♭/, '\\1A#')
          input.gsub!(/(^|\s|\/|on)D♭/, '\\1C#')
          input.gsub!(/(^|\s|\/|on)E♭/, '\\1D#')
          input.gsub!(/(^|\s|\/|on)G♭/, '\\1F#')
        when 'to-flat', 'flat'
          input.gsub!(/(^|\s|\/|on)G#/, '\\1A♭')
          input.gsub!(/(^|\s|\/|on)A#/, '\\1B♭')
          input.gsub!(/(^|\s|\/|on)C#/, '\\1D♭')
          input.gsub!(/(^|\s|\/|on)D#/, '\\1E♭')
          input.gsub!(/(^|\s|\/|on)F#/, '\\1G♭')
        when 'to-japanese', 'doremi'
          input.gsub!(/A/, 'ラ')
          input.gsub!(/B/, 'シ')
          input.gsub!(/C/, 'ド')
          input.gsub!(/D/, 'レ')
          input.gsub!(/E/, 'ミ')
          input.gsub!(/F/, 'ファ')
          input.gsub!(/G/, 'ソ')
        when 'to-doremi', 'doremi'
          input.gsub!(/A#/, 'li')
          input.gsub!(/C#/, 'di')
          input.gsub!(/D#/, 'ri')
          input.gsub!(/F#/, 'fi')
          input.gsub!(/G#/, 'si')
          input.gsub!(/A♭/, 'le')
          input.gsub!(/B♭/, 'te')
          input.gsub!(/D♭/, 're')
          input.gsub!(/E♭/, 'me')
          input.gsub!(/G♭/, 'se')
          input.gsub!(/A/, 'la')
          input.gsub!(/B/, 'ti')
          input.gsub!(/C/, 'do')
          input.gsub!(/D/, 're')
          input.gsub!(/E/, 'mi')
          input.gsub!(/F/, 'fa')
          input.gsub!(/G/, 'so')
        when 'from-doremi'
          input.gsub!(/la/i, 'A')
          input.gsub!(/ti/i, 'B')
          input.gsub!(/do/i, 'C')
          input.gsub!(/re/i, 'D')
          input.gsub!(/mi/i, 'E')
          input.gsub!(/fa/i, 'F')
          input.gsub!(/so/i, 'G')
          input.gsub!(/li/i, 'A#')
          input.gsub!(/di/i, 'C#')
          input.gsub!(/ri/i, 'D#')
          input.gsub!(/fi/i, 'F#')
          input.gsub!(/si/i, 'G#')
          input.gsub!(/le/i, 'A♭')
          input.gsub!(/te/i, 'B♭')
          input.gsub!(/re/i, 'D♭')
          input.gsub!(/me/i, 'E♭')
          input.gsub!(/se/i, 'G♭')
        when 'from-html', 'text-score'
          input.gsub!(/\n/, '')
          input.gsub!(/<br\/?>/, "\n")
          input.gsub!(/<\/p>/, "\n")
          input.gsub!(/<[^>]+>/, ' ')
          input.gsub!(/&nbsp;/, ' ')
          input.gsub!(/　/, '  ')
          input.gsub!(/^ +/, '')
          input.gsub!(/ +$/, '')
          input.gsub!(/／/, '|')
          input.gsub!(/＃/, '#')
          input.gsub!(/   /, '  ')
          input.gsub!(/\n\n\n/, "\n\n")
        else
          return 2
        end
        result = input

        output_stream.puts result
        0
      end
    end
  end
end
