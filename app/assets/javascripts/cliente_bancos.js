$(document).on('ready', () => {
  $(document).off("dblclick", "#cliente_bancos-table tr[id^=cliente_banco]")
  $(document).on("dblclick", "#cliente_bancos-table tr[id^=cliente_banco]", (e) => {
    let id = $(e.currentTarget).attr("id");
    let cliente = $("#cliente_bancos-table").data('cliente-cliente_banco')
    let url = "clientes/" + cliente + "/cliente_bancos/" + id.replace("cliente_banco_", "") + "/editar"
    $.ajax({ type: "GET", url: url });
  });

  $(document).off("click", "#cliente_banco_banco_codigo")
  $(document).on("click", "#cliente_banco_banco_codigo", () => {
    let url = "/bancos/lista_bancos"
    $.ajax({ type: "GET", url: url,
      success: () => {
        setTimeout(() => {
          carrega_datatable("bancos","banco", ["codigo","nome"], []);
        }, 200)

      }
    });
  });

  cidades_dropdown('cliente_banco');

  $(document).off("click", "a[href='#cliente-cliente_bancos'].standby")
  $(document).on("click", "a[href='#cliente-cliente_bancos'].standby", (e) => {
    var campos = ["banco_codigo","banco_nome","agencia","conta_corrente","cidade_nome","estado_sigla","correntista_nome","correntista_cpf_cnpj","observacao","created_at","primario","ativo"];
    carrega_datatable_filtro("cliente_bancos","cliente_banco", campos, []);
    $(e.currentTarget).removeClass("standby");
  })
});
