$(document).on('turbolinks:load', function(){
  $(document).off('click', '#alertas-somente-ativos, #alertas-exibir-todos')
  $(document).on('click', '#alertas-somente-ativos, #alertas-exibir-todos', function(){
    $("#alertas-table").dataTable().fnDraw();
  });

  $(document).off('click', '#alerta_somente_ativos_Btn')
  $(document).on('click', '#alerta_somente_ativos_Btn', function(e){
    var table = $("#alertas-table").DataTable();
    table.column(3).search("1").draw()
    $("#alerta_exibir_todos_Btn").toggleClass("hide")
    $(this).toggleClass("hide")
  });
  $(document).off('click', '#alerta_exibir_todos_Btn')
  $(document).on('click', '#alerta_exibir_todos_Btn', function(e){
    var table = $("#alertas-table").DataTable();
    table.column(3).search("").draw()
    $("#alerta_somente_ativos_Btn").toggleClass("hide")
    $(this).toggleClass("hide")
  });

  $(document).off("click", "a[href='#cliente-alertas'].standby")
  $(document).on("click", "a[href='#cliente-alertas'].standby", function(){
    var campos = ["tipo","created_at","descricao","ativo","qtde_comentarios","created_by"];
    carrega_datatable_filtro("alertas","alerta", campos, [4,5]);
    $(this).removeClass("standby");
  })


  var clicks, timer, delay;
  clicks=0;delay=500;timer=null;

  $(document).off('click', "#alertas-table tr[id^=alerta]")
  $(document).on('click', "#alertas-table tr[id^=alerta]", function(){
    row = $(this);
    clicks++;
    timer = setTimeout(function() {
      switch(clicks){
        case 1:
          var id = row.attr("id");
          var url = "alertas/" + id.replace("alerta_", "") + "/alerta_comentarios.js"

          $.ajax({ type: "GET", url: url,
            success: function(){
              carrega_datatable_sem_controles("alerta_comentarios","alerta_comentario", ["created_at","descricao"], []);
            }
          });
        break;
        case 2:
          var id = row.attr("id");
          var cliente = $("#alertas-table").data('cliente-alerta')
          var url = "clientes/" + cliente + "/alertas/" + id.replace("alerta_", "") + "/editar.js"

          $.ajax({ type: "GET", url: url });
        break;
      }
      clicks=0;
    }, delay);
  });
});
