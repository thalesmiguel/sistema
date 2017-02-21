$(document).on('turbolinks:load', function(){
  var campos = ["nome","tipo","parcelas","captacoes","frequencia","entrada"];
  carrega_datatable_filtro("pagamento_condicoes","pagamento_condicao", campos, []);

  $(document).off("dblclick", "#pagamento_condicoes-table tr[id^=pagamento_condicao]")
  $(document).on("dblclick", "#pagamento_condicoes-table tr[id^=pagamento_condicao]", function(){

    var id = $(this).attr("id");
    var url = "/pagamento_condicoes/" + id.replace("pagamento_condicao_", "") + "/editar"
    $.ajax({ type: "GET", url: url }).success(() => {
      if ($("#pagamento_condicao_tipo").val() == 'datas_diferenciadas') { $(".parcela_vencimento").removeClass("hidden"); }
    });
  });

  $(document).off("change", "#pagamento_condicao_tipo");
  $(document).on("change", "#pagamento_condicao_tipo", (e) => {
    switch (e.target.options[e.target.selectedIndex].value) {
      case 'datas_diferenciadas':
        $(".parcela_vencimento").removeClass("hidden");
        break;
      default:
        $(".parcela_vencimento").addClass("hidden");
    }
  });

});
