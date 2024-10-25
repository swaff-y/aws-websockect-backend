# frozen_string_literal: true

require_relative 'base'

module Controllers
  class Policy < Base # rubocop:disable Style/Documentation
    def self.policy_response(msg)
      new(msg).process_message
    end

    def process_message
      puts 'Processing Policy API'

      policy_message
    end

    private

    def policy_message
      {
        'request' => @msg['message'],
        'response' => 'Welcome to Contact API'
      }
    end
  end
end
