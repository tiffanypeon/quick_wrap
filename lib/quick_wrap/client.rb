require 'faraday'
require 'json'
module  QuickWrap
  class Client

    attr_accessor *Configuration::VALID_CONFIG_KEYS

    ## ideas
    ##to intercept call on obj
    # def method_missing(name, *args, &block)
    #   response_body.has_key?(name.to_s) ? response_body[name.to_s] : super
    # end
    ##QuickWrap base that everything inherits from
    ##for cacheing - move into a private method
    # def response_body(force = false)
    #   force ? @response_body = get_response_body : @response_body ||= get_response_body
    # end

    ## end ideas

    def initialize(options={})
      merged_options = QuickWrap.options.merge(options)
      Configuration::VALID_CONFIG_KEYS.each do |key|
        send("#{key}=", merged_options[key])
      end
    end

    #Method types:
    ##simple:
    def get_thing(path)
      get(path)
    end
    ##path is constructed with arg
    def get_thing_with_id(path, id)
      get("#{path}/#{id}")
    end
    ##requests with params
    def post_with_params(path, params={})
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

    private

    def etag_opts(etag)
      {
        headers: { 'If-Match' => etag },
        multipart: true
      }

    def connection(opts = {})
      opts[:headers] ||= { 'Accept' => 'application/json' }

      Faraday.new(url: endpoint) do |faraday|
        faraday.headers = opts[:headers]
        faraday.request :multipart if opts[:multipart]

        faraday.authorization :Bearer, token
        faraday.adapter  :httpclient  # make requests with Net::HTTP
        faraday.request :url_encoded
      end
    end

    ##== Setup autogenerate for new API token ==##
    # def token
    #   @token ||= YOURAPI::Token.new(token_params).token
    # end

    def request(method, path, params = {})
      etag = params.delete(:etag)
      opts = etag ? etag_opts(etag) : {}

      response = connection.send(method, path) do |request|
        request.params = params if method == :get
        request.body = params if method == :post
      end
    end

  end

  class ConfigurationError < StandardError; end
end
