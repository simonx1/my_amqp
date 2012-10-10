# encoding: utf-8

require "rubygems"
require "amqp"

trap('INT') do
  EM.stop
end

EventMachine.run do
  connection = AMQP.connect(:host => '127.0.0.1')
  puts "Connected to AMQP broker. Running #{AMQP::VERSION} version of the gem..."

  channel = AMQP::Channel.new(connection)
  queue = channel.queue("some.key", :auto_delete => true)

  queue.subscribe do |payload|
    puts "Received a message: #{payload}."
  end

end

