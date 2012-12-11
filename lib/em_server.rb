class EmServer < EventMachine::Connection
  @@clients = []

  def self.start
    EventMachine::start_server(Flower::Config.em_server_ip, Flower::Config.em_server_port, self)
  end

  def self.post(data)
    @@clients.each do |client|
      client.send_data("#{data}\n")
      EM.next_tick {}
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
