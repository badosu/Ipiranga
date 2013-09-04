module Ipiranga
  class Exception < StandardError
    attr_accessor :result

    def initialize(error)
      if error.kind_of?(String)
        super(error)
      else
        @result = error
        super(error["msgErro"])
      end
    end

    def inspect
      "#{message}#{" - response: #{result.inspect}" unless result.nil?}"
    end

    def to_s
      inspect
    end
  end

  class RequestAlreadyExists < ::Exception; end
  class UserAlreadyExists < ::Exception; end
  class InvalidCredentials < ::Exception; end
  class InternalError < ::Exception; end
end
