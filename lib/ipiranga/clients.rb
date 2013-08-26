require 'ipiranga/client'

module Ipiranga
  class PF < Client
    def wsdl_url
      "https://b2bdv.ipiranga.com.br/csp/ensb2cws/cbpi.bs.participantePF.Service.CLS?WSDL=1"
    end
  end

  class KM < Client
    def wsdl_url
      "https://b2bdv.ipiranga.com.br/csp/ensb2cws/cbpi.bs.km.pedido.Service.CLS?WSDL=1"
    end
  end
end
