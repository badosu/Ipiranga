require 'lolsoap'
require 'open-uri'
require 'net/http'
require 'uri'
require 'akami'

module Ipiranga
  class Client
    attr_reader :soap, :wsdl_url
    attr_accessor :wsdl, :username, :password

    def initialize(opts = {})
      @wsdl_url = URI(opts.fetch(:wsdl_url, wsdl_url))
      @username = opts[:username]
      @password = opts[:password]
      @wsdl = opts[:wsdl]

      operations.each do |operation|
        define_singleton_method("post_#{operation}") do |&block|
          post(operation, &block)
        end

        define_singleton_method(operation) do |&block|
          post(operation, &block).body_hash
        end unless respond_to?(operation)
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

    def operation(key)
      soap.wsdl.operations[key]
    end

    def post(operation)
      request = soap.request(operation)

      pRequest = request.body.pRequest

      yield pRequest if block_given?

      append_wsse(request) if has_credentials?

      uri = URI(request.url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http_response = http.post(uri.path.gsub(".cls", ".CLS"), request.content, request.headers)

      soap.response(request, http_response.body)
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
