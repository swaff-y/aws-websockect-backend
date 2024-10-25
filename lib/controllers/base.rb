# frozen_string_literal: true

module Controllers
  class Base # rubocop:disable Style/Documentation
    def self.respond_message(msg)
      new(msg).respond_message
    end

    def initialize(msg)
      @msg = msg
    end

    def process_message
      raise StandardError, 'method not implemented'
    end

    def respond_message
      case @msg['api']
      when 'policy'
        JSON.generate(Controllers::Policy.policy_response(@msg))
      when 'contact'
        JSON.generate(Controllers::Contact.contact_response(@msg))
      else
        JSON.generate({ 'message' => 'Invalid API' })
      end
    end
  end
end
