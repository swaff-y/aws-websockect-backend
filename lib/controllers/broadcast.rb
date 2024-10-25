# frozen_string_literal: true

module Controllers
  class Broadcast # rubocop:disable Style/Documentation
    def initialize(msg)
      @msg = msg
    end

    def broadcast_message
      case @msg['api']
      when 'whics'
        JSON.generate(Controllers::Whics.whics_response(@msg))
      else
        JSON.generate({ 'message' => 'Invalid API' })
      end
    end
  end
end
