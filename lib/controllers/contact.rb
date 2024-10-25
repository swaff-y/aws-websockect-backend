# frozen_string_literal: true

require_relative 'base'

module Controllers
  class Contact < Base # rubocop:disable Style/Documentation
    def self.contact_response(msg)
      new(msg).process_message
    end

    def process_message
      puts 'Processing Contact API'

      contact_message
    end

    private

    def contact_message
      {
        'request' => @msg['message'],
        'response' => 'Welcome to Contact API'
      }
    end
  end
end
