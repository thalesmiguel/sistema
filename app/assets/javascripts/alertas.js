$(document).on('turbolinks:load', function(){
  // carrega_datatable_id_automatico("#alertas-table", ".alerta-form", ".excluir-alerta", [], [0,1,2,3,4,5]);

  $(document).on('click', '#alertas-somente-ativos, #alertas-exibir-todos', function(){
    $("#alertas-table").dataTable().fnDraw();
    // $("#alertas-table").DataTable().destroy();
    //
    // setTimeout(function(){
    //   carrega_datatable_id_automatico("#alertas-table", ".alerta-form", ".excluir-alerta", [], [0,1,2,3,4,5]);
    // }, 100);
  });

  $(document).on('click', '#bozoBtn', function(e){
    e.preventDefault();
    var table = $("#alertas-table").DataTable();
    console.log("123");
    table
      .columns( 6 )
      .search(  'abc' )
      .draw();

    // table.columns(0).search("").draw()
  });


  var clicks, timer, delay;
  clicks=0;delay=500;timer=null;

  $(document).on('click', "#alertas-table tr[id^=alerta]", function(){
    row = $(this);
    clicks++;
    timer = setTimeout(function() {
      switch(clicks){
        case 1:

          var id = row.attr("id");
          var url = "alertas/" + id.replace("alerta_", "") + "/alerta_comentarios.js"

          $.ajax({
            type: "GET",
            url: url,
            success: function(){
              carrega_datatable_id_automatico_sem_controles("#alerta_comentarios-table", ".alerta_comentario-form", ".excluir-alerta_comentario", [], [0,1]);
            }
          });

        break;
        case 2:

          var id = row.attr("id");
          var cliente = $("#alertas-table").data('cliente-alerta')
          var url = "clientes/" + cliente + "/alertas/" + id.replace("alerta_", "") + "/editar.js"

          $.ajax({
            type: "GET",
            url: url
          });

        break;
      }
      clicks=0;
    }, delay);
  });
});
