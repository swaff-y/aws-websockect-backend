#!/usr/bin/env ruby

require 'sinatra'
require 'sinatra-websocket'
require 'openssl'
require_relative '../lib/lambda/message_handler'

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
        message_handler(ws, msg)
      end
      ws.onclose do
        warn('websocket closed')
        settings.sockets.delete(ws)
      end
    end
  end
end
