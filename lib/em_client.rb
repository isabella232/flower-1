#!/usr/bin/env ruby
#
# client_1

require 'rubygems'
require 'eventmachine'

class EmClient < EventMachine::Connection
  def post_init
    start_input_listener
  end

  def start_input_listener
    # send_data "Hello from Richard"
  end

  def receive_data(data)
    puts "want to play #{data.inspect}"
    path_to_file = File.expand_path(File.join(__FILE__, "..", "..", "extras", data))
    system "afplay", path_to_file
  end
end
