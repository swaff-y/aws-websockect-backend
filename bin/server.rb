#!/usr/bin/env ruby

require 'sinatra'
require 'sinatra-websocket'
require 'openssl'

set :server, 'thin'
set :sockets, []

get '/' do
  if request.websocket?
    request.websocket do |ws|
      ws.onopen do
        ws.send('Welcome to your websocket!')
        settings.sockets << ws
      end
      ws.onmessage do |msg|
        puts "Received message: #{ws.object_id} => #{msg}"
        msg = JSON.parse(msg)
        settings.sockets.each do |s|
          if ws.object_id.equal?(s.object_id) && msg['type'] == 'self'
            EM.next_tick { s.send(msg['message']) }
          end

          if msg['type'] == 'broadcast'
            EM.next_tick { s.send(msg['message']) }
          end
        end
      end
      ws.onclose do
        warn('websocket closed')
        settings.sockets.delete(ws)
      end
    end
  end
end
