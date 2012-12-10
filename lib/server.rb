class Server < EventMachine::Connection
  @@clients = []

  def self.post(data)
    @@clients.each do |client|
      puts "Going to push: #{data.inspect}"
      client.send_data(data)
    end
  end

  def post_init
    @@clients << self
  end

  def receive_data(data)
    # Do nothing
  end

  def unbind
    # Do nothing
  end
end
