$(document).on('ready', () => {
  let buscar_cep = (e) => {
    let cep = e.currentTarget.value.replace("-","").replace(".","").trim();
    if (cep != "") {
      let url = "/ceps/" + cep + "/buscar";
      $.ajax({ type: "GET", url: url });
    };
  };

  $(document).on("blur", ".cep", (e) => { buscar_cep(e) });
})
