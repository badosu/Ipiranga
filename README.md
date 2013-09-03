Ipiranga
========

Usage
-----

### Client

This is the base class that sends requests and parse responses to the Ipiranga
Web Services:

    wsdl_url = "https://b2bdv.ipiranga.com.br/csp/ensb2cws/cbpi.bs.participantePF.Service.CLS?WSDL=1"
    ipiranga = Ipiranga::Client.new(wsdl_url: wsdl_url)

### PF and KM

There are two modules: PF and KM (for registering people and giving credit,
respectively).

You can use the `Client` subclasses so that you don't need to specify the wsdl
urls.

It uses the `RAILS_ENV` variables as well, check `lib/ipiranga/clients.rb` for
more details.

### Credentials

Ipiranga uses WSSE for security, so you need to specify your credentials:

    ipiranga_pf = Ipiranga::PF.new(username: "badosu",
                                   password: "pass")

### PF - Cadastrar

    ipiranga_pf.cadastrar do |b|
      b.idRequisitante "Badosu"
      b.nome "John"
      b.sobreNome "Doe"
      b.cpf 12345678991
      b.dataNascimento Date.parse('27/05/1986').
                            strftime("%Y-%m-%dT%H:%M:%S")
    end

### KM - GerarPedidoAcumulo

    ipiranga_km.gerarPedidoAcumulo do |b|
      b.Requisitante "badosu"
      b.CPF 36918756885
      b.CodigoPedido 1
      b.Produto do |p|
        produtoKM = p.ProdutoKM
        produtoKM.IdItem 1
        produtoKM.CodigoProduto "1"
        produtoKM.Quantidade 1
        produtoKM.KM 100
        produtoKM.TipoAcumulo "2"
      end
    end
