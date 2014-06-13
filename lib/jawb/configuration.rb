module Jawb
  module Configuration

    def configure
      yield self
    end

    VALID_CONNECTION_KEYS = [:endpoint, :environment, :user_agent].freeze
    VALID_OPTIONS_KEYS    = [:authorization, :format].freeze
    VALID_CONFIG_KEYS     = VALID_CONNECTION_KEYS + VALID_OPTIONS_KEYS

    DEFAULT_ENDPOINT      = 'your endpoint here'
    DEFAULT_USER_AGENT    = "Jawb API Ruby Gem #{Jawb::VERSION}".freeze

    DEFAULT_FORMAT        = :json

    attr_accessor *VALID_CONFIG_KEYS

    # Make sure we have the default values set when we get 'extended'
    def self.extended(base)
      base.reset
    end

     def options
      Hash[ * VALID_CONFIG_KEYS.map { |key| [key, send(key)] }.flatten ]
    end

    def reset
      self.authorization    = nil
      self.environment      = nil
      self.endpoint         = DEFAULT_ENDPOINT
      self.user_agent       = DEFAULT_USER_AGENT
      self.format           = DEFAULT_FORMAT
    end

  end
end
