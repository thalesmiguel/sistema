$(document).on('ready', () => {
  // let campos = ["nome","evento","recinto","cidade_nome","estado_sigla","data_inicio","hora_inicio"];
  // carrega_datatable_filtro("leiloes","leilao", campos, []);

  $(document).off("dblclick", "#leiloes-table tr[id^=leilao]");
  $(document).on("dblclick", "#leiloes-table tr[id^=leilao]", (e) => {
    let id = $(e.currentTarget).attr("id");
    let url = "/leiloes/" + id.replace("leilao_", "") + "/seleciona_leilao"
    $.ajax({ type: "PUT", url: url });
  });

  $(document).off("click", "#leilao_leilao_evento_nome");
  $(document).on("click", "#leilao_leilao_evento_nome", () => {
    var url = "/leilao_eventos/lista_eventos"
    $.ajax({ type: "GET", url: url,
      success: () => {
        carrega_datatable("leilao_eventos","leilao_evento", ["nome", "data_inicio", "data_fim"], []);
      }
    });
  });

  $("#limpa_evento").off("click");
  $("#limpa_evento").on("click", () => {
    $("#leilao_leilao_evento_id").val("");
    $("#leilao_leilao_evento_nome").val("");
    $("label[for='leilao_leilao_evento_nome']").removeClass("active");
    $("#salvar_leilao").prop("disabled", false)
  });

  $(document).off("click", "#leilao_leilao_anterior_nome");
  $(document).on("click", "#leilao_leilao_anterior_nome", (e) => {
    let id = $(".leilao-form").attr("action").replace("/leiloes/","");
    var url = "/leiloes/" + id + "/lista_leiloes_anteriores";
    $.ajax({ type: "GET", url: url,
      success: () => {
        let campos = ["nome","evento","recinto","cidade_nome","estado_sigla","data_inicio","hora_inicio","categoria"];
        carrega_datatable("leiloes_anteriores","leilao_anterior", campos, []);
      }
    });
  });

  $("#limpa_leilao_anterior").off("click");
 	$("#limpa_leilao_anterior").on("click", () => {
    $("#leilao_leilao_anterior_id").val("");
    $("#leilao_leilao_anterior_nome").val("");
    $("label[for='leilao_leilao_anterior_nome']").removeClass("active");
    $("#salvar_leilao").prop("disabled", false)
  });


  $('#leilaoTabs').tabs({
    onShow: (tab) => { $('ul.tabs').tabs(); }
  });

  cidades_dropdown('leilao');
  $('select').material_select();
  mascaras();
  valida_formulario();
  $('.materialboxed').materialbox();
});
