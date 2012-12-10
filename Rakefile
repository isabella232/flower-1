task :spec do
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new
end

require File.expand_path(File.join(File.dirname(__FILE__), 'lib', 'flower'))

task :run do
  @flower = Flower.new
  @flower.boot!
end

task :client do
  require File.expand_path(File.join(File.dirname(__FILE__), 'lib', 'em_client'))
  EventMachine.run {
    puts "Connecting to #{ARGV[1]}..."
    EventMachine.connect ARGV[1], 6000, EmClient
  }
end

task :console do
  require_relative 'lib/flower'
  require_relative 'lib/console'
  require 'irb'
  require 'irb/completion'

  def message message
    results = []
    results << Flower::Console.command(message)
    results << Flower::Console.listen(message)
    results.flatten.compact
  end

  ARGV.clear
  IRB.start
end

Signal.trap(0) do
  @flower.say("I'm leaving (and/or crashing)... Goodbye!")
end
