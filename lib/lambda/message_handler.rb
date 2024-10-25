# frozen_string_literal: true

require_relative '../controllers/respond'

def message_handler(ws, msg)
  puts "Received message: #{ws.object_id} => #{msg}"
  msg = JSON.parse(msg)
  settings.sockets.each do |s|
    if ws.object_id.equal?(s.object_id) && msg['type'] == 'self'
      EM.next_tick { s.send(Controllers::Respond.respond_message(msg)) }
    end

    if msg['type'] == 'broadcast'
      EM.next_tick { s.send(Controllers::Respond.respond_message(msg)) }
    end
  end
rescue JSON::ParserError
  puts 'Invalid JSON'
  ws.send('Invalid JSON')
rescue StandardError, ArgumentError => e # rubocop:disable Lint/ShadowedException
  puts "Error: #{e}"
  ws.send("Error: #{e}")
end
