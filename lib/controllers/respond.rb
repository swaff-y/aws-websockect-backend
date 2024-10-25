# frozen_string_literal: true

module Controllers
  class Respond # rubocop:disable Style/Documentation
    def initialize(msg)
      @msg = msg
    end

    def respond_message
      case @msg['api']
      when 'whics'
        JSON.generate(Controllers::Whics.whics_response(@msg))
      else
        JSON.generate({ 'message' => 'Invalid API' })
      end
    end
  end
end
