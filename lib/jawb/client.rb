require 'faraday'
require 'json'
module  Jawb
  class Client
    PROMOTABLE_TYPES = [:smart_coupon]

    attr_accessor *Configuration::VALID_CONFIG_KEYS

    ## ideas
    ##to intercept call on obj
    def method_missing(name, *args, &block)
      response_body.has_key?(name.to_s) ? response_body[name.to_s] : super
    end
    ##Jawb base that everything inherits from
    ##for cacheing - move into a private method
    def response_body(force = false)
      force ? @response_body = get_response_body : @response_body ||= get_response_body
    end

    ## end ideas

    def initialize(options={})
      merged_options = Jawb.options.merge(options)
      Configuration::VALID_CONFIG_KEYS.each do |key|
        send("#{key}=", merged_options[key])
      end
      if environment.nil?
        raise ConfigurationError.new '.environment must be one of [d1, l1, f1, stage, prod]!'
      end
    end

    def connection
      @connection ||= Faraday.new(:url => endpoint) do |faraday|
        # faraday.headers['Content-Type'] = 'application/json'
        # faraday.headers['Ctct-Environment'] = environment
        # faraday.authorization :Token, authorization
        faraday.adapter  :httpclient  # make requests with Net::HTTP
      end
    end

    #Method types:
    ##simple:
    def get_thing(path)
      path = '/endpoint.json'
      get(path)
    end
    ##path is constructed with arg
    def get_thing_with_id(path, id)
      path = '/endpoint/#{id}.json'
      get(path)
    end
    ##requests with params
    def post_with_params(path, params={})
      path = '/endpoint.json'
      post(path, params)
    end

    ##standard methods
    def get(path)
      request(:get, path)
    end

    def post(path, params = {})
      request(:post, path, params)
    end

    def put(path, params = {})
      request(:put, path, params)
    end

    def delete(path, params = {})
      request(:delete, path, params)
    end

    def request(method, path, params = {})
      res = connection.send(method, path) do |request|
        request.body = JSON.generate(params) if params
      end
    end

    private

  end

  class ConfigurationError < StandardError; end
end
