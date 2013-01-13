if RUBY_VERSION <= '1.8.7'
else
  require "simplecov"
  require "simplecov-rcov"
  SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
  SimpleCov.start
end

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require "rspec"
require "transcore"
require "tempfile"

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  
end

module Transcore
  TRANSCORE_HOME = File.expand_path(File.dirname(__FILE__) + "/..")
  REDIRECT = {}
end

Transcore.logger = Logger.new(STDERR)
if File.exist?('/tmp/transcore.debug') then
  Transcore.logger.level = Logger::DEBUG
  Transcore::REDIRECT[:stdout] = nil
  Transcore::REDIRECT[:stderr] = nil
else
  Transcore.logger.level = Logger::ERROR
  Transcore::REDIRECT[:stdout] = "> /dev/null"
  Transcore::REDIRECT[:stderr] = "2> /dev/null"
end
