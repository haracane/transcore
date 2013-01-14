module Transcore
  module Command
    module Default
      def self.run(argv, input_stream=$stdin, output_stream=$stdout)
        command = argv[0]
        if /^[+\-]?[0-9]+$/ =~ command
          return Transcore::Command::Transpose.run(argv, input_stream, output_stream)
        else
          case command
          when "sharp"
            return Transcore::Command::Convert.run(argv, input_stream, output_stream)
          when "flat"
            return Transcore::Command::Convert.run(argv, input_stream, output_stream)
          when "doremi"
            return Transcore::Command::Convert.run(argv, input_stream, output_stream)
          when "text-score"
            return Transcore::Command::Convert.run(argv, input_stream, output_stream)
          else
            return 2
          end
        end
      end
    end
  end
end
