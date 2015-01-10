module Transcore
  module Command
    module Default
      def self.run(argv, input_stream = $stdin, output_stream = $stdout)
        command = argv[0]
        if /^[+\-]?[0-9]+$/ =~ command
          return Transcore::Command::Transpose.run(argv, input_stream, output_stream)
        else
          return Transcore::Command::Convert.run(argv, input_stream, output_stream)
        end
      end
    end
  end
end
