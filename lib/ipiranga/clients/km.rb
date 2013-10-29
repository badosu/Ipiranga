require 'ipiranga/client'

module Ipiranga
  class KM < Client
    def wsdl_url
      if defined?(ENV["RAILS_ENV"]) && ENV["RAILS_ENV"] == "production"
        "https://b2b.ipiranga.com.br/csp/ensb2cws/cbpi.bs.km.pedido.Service.CLS?WSDL=1"
      else
        "https://b2bdv.ipiranga.com.br/csp/ensb2cws/cbpi.bs.km.pedido.Service.CLS?WSDL=1"
      end
    end

    def gerarPedidoAcumulo(&block)
      result = post_gerarPedidoAcumulo(&block).
                 body_hash["gerarPedidoAcumuloResult"]

      raise RequestAlreadyExists.new(result) if result["codigoRetorno"] == "2"
      raise ::Exception.new(result) if result["codigoRetorno"] != "0"

      return result["codigoRequisicao"].to_i
    end
  end
end
