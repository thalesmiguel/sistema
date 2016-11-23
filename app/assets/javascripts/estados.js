$(document).ready(function() {
  var estadosTable = $('#estados-table').dataTable({
    "processing": true,
    "serverSide": true,
    "ajax": $('#estados-table').data('source'),
    "pagingType": "full_numbers",
    "language": {
        "decimal":        "",
        "emptyTable":     "Dados não encontrados",
        "info":           "Mostrando _START_ a _END_ de _TOTAL_ registros",
        "infoEmpty":      "Mostrando 0 a 0 de 0 registros",
        "infoFiltered":   "(filtered from _MAX_ total entries)",
        "infoPostFix":    "",
        "thousands":      ",",
        "lengthMenu":     "Mostrar _MENU_",
        "loadingRecords": "Carregando...",
        "processing":     "<div class='progress secondary-color'> <div class='indeterminate'></div> </div>",
        "search":         "Pesquisar:",
        "zeroRecords":    "Sem registros para mostrar",
        "paginate": {
            "first":      "Primeiro",
            "last":       "Último",
            "next":       "Próximo",
            "previous":   "Anterior"
        },
        "aria": {
            "sortAscending":  ": ative para ordenar a coluna de forma ascendente",
            "sortDescending": ": ative para ordenar a coluna de forma descendente"
        }
    }
    // optional, if you want full pagination controls.
    // Check dataTables documentation to learn more about
    // available options.
  });

  $(document).on('ajax:complete', ".estado-form", function(){
    estadosTable.fnUpdate();
  });
  $(document).on('ajax:complete', ".estado-excluir", function(){
    estadosTable.fnUpdate();
  });

});
