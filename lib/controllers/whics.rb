# frozen_string_literal: true

module Controllers
  class Whics # rubocop:disable Style/Documentation
    def self.whics_response(msg)
      new(msg).whics_message
    end

    def initialize(msg)
      @msg = msg
    end

    def whics_message
      {
        'request' => @msg['message'],
        'response' => 'Welcome to WHICS'
      }
    end
  end
end
