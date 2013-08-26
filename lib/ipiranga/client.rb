require 'lolsoap'
require 'open-uri'
require 'net/http'
require 'uri'
require 'akami'

module Ipiranga
  class Client
    attr_reader :wsdl, :soap, :wsdl_url
    attr_accessor :username, :password

    def initialize(opts = {})
      @wsdl_url = URI(opts.fetch(:wsdl, wsdl_url))
      @username = opts[:username]
      @password = opts[:password]

      operations.each do |operation|
        define_singleton_method(operation) do |&block|
          post(operation, &block)
        end
      end
    end

    def wsdl
      @wsdl ||= open(@wsdl_url.to_s).read.gsub("http://eaidev:2010", "https://#{@wsdl_url.host}")
    end

    def soap
      @soap ||= LolSoap::Client.new(wsdl)
    end

    def operations
      soap.wsdl.operations.keys
    end

    def post(operation)
      request = soap.request(operation)

      yield request.body if block_given?

      append_wsse(request) if has_credentials?

      uri = URI(request.url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http_response = http.post(uri.path.gsub(".cls", ".CLS"), request.content, request.headers)

      soap.response(request, http_response.body).body_hash
    end

    def has_credentials?
      !username.nil? && !password.nil?
    end

    private

    def append_wsse(request)
      wsse = Akami.wsse
      wsse.credentials(username, password)
      request.header.__node__ << wsse.to_xml
    end
  end
end
