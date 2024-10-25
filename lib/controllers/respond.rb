# frozen_string_literal: true

require_relative '../controllers/base'
require_relative '../controllers/policy'
require_relative '../controllers/contact'
module Controllers
  class Respond < Base # rubocop:disable Style/Documentation
    def self.respond_message(msg)
      new(msg).respond_message
    end
  end
end
