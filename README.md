Ipiranga
========

Usage
-----

    km = Ipiranga::KM.new(username: "badosu", password: "pass")
    km.cancelarPedido do |b|
      b.CPF "123.456.789-9"
      b.Requisitante "Badosu"
      b.CodigoRequisicao "9812741985"
    end
