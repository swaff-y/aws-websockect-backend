# frozen_string_literal: true

require_relative '../controllers/respond'
require_relative '../controllers/broadcast'
require_relative '../controllers/whics'

def message_handler(ws, msg)
  puts "Received message: #{ws.object_id} => #{msg}"
  msg = JSON.parse(msg)
  settings.sockets.each do |s|
    if ws.object_id.equal?(s.object_id) && msg['type'] == 'self'
      respond = Controllers::Respond.new(msg)
      EM.next_tick { s.send(respond.respond_message) }
    end

    if msg['type'] == 'broadcast'
      broadcast = Controllers::Broadcast.new(msg)
      EM.next_tick { s.send(broadcast.broadcast_message) }
    end
  end
rescue JSON::ParserError
  puts 'Invalid JSON'
  ws.send('Invalid JSON')
end
