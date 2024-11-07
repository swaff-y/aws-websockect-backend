# frozen_string_literal: true

require_relative 'base'
require 'httparty'

module Controllers
  class Contact < Base # rubocop:disable Style/Documentation
    include HTTParty
    base_uri 'https://jsonplaceholder.typicode.com' # Replace with the base URL of the API you are calling

    def self.contact_response(msg)
      new(msg).process_message
    end

    def process_message
      puts 'Processing Contact API'

      contact_message
    end

    private

    def contact_message
      endpoint = @msg.dig('message', 'endpoint')
      case endpoint
      when 'users'
        users
      else
        {
          'request' => @msg['message'],
          'response' => 'Invalid endpoint'
        }
      end
    end

    def users
      response = self.class.get('/users')
      if response.success?
        requested_attributes = @msg.dig('message', 'attributes')
        if requested_attributes
          response = JSON.parse(response.body).map do |user|
            user.select { |key, _value| requested_attributes.include?(key) }
          end
          {
            'request' => @msg['message'],
            'response' => JSON.generate(response)
          }
        else
          {
            'request' => @msg['message'],
            'response' => 'API call failed'
          }
        end
      else
        {
          'request' => @msg['message'],
          'response' => 'API call failed'
        }
      end
    end
  end
end
