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

  class UserAlreadyExists < ::Exception; end
  class InvalidCredentials < ::Exception; end
  class InternalError < ::Exception; end

  def self.raise_exception(result)
    case result["msgErro"]
    when "Usuario/Password Inválido"
      raise InvalidCredentials.new(result)
    when "Erro interno"
      raise InternalError.new(result)
    else
      raise ::Exception.new(result)
    end
  end
end
