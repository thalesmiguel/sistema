$(() => {
  $(document).off("click", "#home_selecionar_leilao")
  $(document).on("click", "#home_selecionar_leilao", () => {
    let url = "/leiloes/"
    $.ajax({ type: "GET", url: url });
  });
});
