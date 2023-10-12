class MessageWorker
  include Sneakers::Worker
  from_queue 'messages'

  def work(message)
    puts "Received message: #{message}"
    ack! # we need to let queue know that message was received
  end
end
