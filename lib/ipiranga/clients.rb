require 'ipiranga/client'

module Ipiranga
  class PF < Client
    def wsdl_url
      if defined?(RAILS_ENV) && RAILS_ENV == "production"
        "https://b2b.ipiranga.com.br/csp/ensb2cws/cbpi.bs.participantePF.Service.CLS?WSDL=1"
      else
        "https://b2bdv.ipiranga.com.br/csp/ensb2cws/cbpi.bs.participantePF.Service.CLS?WSDL=1"
      end
    end

    def cadastrar(&block)
      result = post_cadastrar(&block)["cadastrarResult"]

      Ipiranga.raise_exception(result) if result["status"].nil? || result["status"] == "false"

      if result["status"] == "true" && result["statusMimetica"] == "2"
        raise UserAlreadyExists.new(result)
      end

      return result["statusMimetica"] == "0"
    end
  end

  class KM < Client
    def wsdl_url
      if defined?(RAILS_ENV) && RAILS_ENV == "production"
        "https://b2b.ipiranga.com.br/csp/ensb2cws/cbpi.bs.km.pedido.Service.CLS?WSDL=1"
      else
        "https://b2bdv.ipiranga.com.br/csp/ensb2cws/cbpi.bs.km.pedido.Service.CLS?WSDL=1"
      end
    end
  end
end
