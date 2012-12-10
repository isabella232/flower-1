class Server < EventMachine::Connection
  @@clients = []

  def self.post(data)
    @@clients.each do |client|
      client.send_data("#{data}\n")
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
