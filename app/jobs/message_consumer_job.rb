class MessageConsumerJob < ApplicationJob
  queue_as :default

  def perform
    connection = Bunny.new
    connection.start

    channel = connection.create_channel
    exchange = channel.fanout('logs')
    queue = channel.queue('', exclusive: true)

    queue.bind(exchange)

    puts 'Waiting for messages. To exit press CTRL+C'

    queue.subscribe(block: true) do |delivery_info, _properties, body|
      puts "Received: #{body}"
    end
  end
end
