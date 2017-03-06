$(document).on('ready', () => {
  var campos = ["username","email","created_at","updated_at"];
  carrega_datatable_filtro("users","user", campos, []);

  $(document).off("dblclick", "#users-table tr[id^=user]")
  $(document).on("dblclick", "#users-table tr[id^=user]", (e) => {
    var id = $(e.currentTarget).attr("id");
    var url = "/users/" + id.replace("user_", "") + "/edit"
    $.ajax({ type: "GET", url: url });
  });
});
