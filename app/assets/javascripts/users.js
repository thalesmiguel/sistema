$(document).on('turbolinks:load', function(){
  carrega_datatable("users","user", ["username","email","created_at","updated_at"], []);

  $(document).on("dblclick", "#users-table tr[id^=user]", function(){
    var id = $(this).attr("id");
    var url = "/users/" + id.replace("user_", "") + "/edit"
    $.ajax({ type: "GET", url: url });
  });

});
