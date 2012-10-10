#!/usr/bin/env ruby
# encoding: utf-8

require "rubygems"
require "amqp"

trap('INT') do
  EM.stop
  exit
end


EventMachine.run do
  connection = AMQP.connect(:host => '127.0.0.1')
  puts "Connected to AMQP broker. Running #{AMQP::VERSION} version of the gem..."

  channel = AMQP::Channel.new(connection)
  exchange = channel.direct("")

  loop do
    print "Enter message: \n"
    line = readline
    exchange.publish line, :routing_key => 'some.key'
  end

end
