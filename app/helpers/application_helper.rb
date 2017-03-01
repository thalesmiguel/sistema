module ApplicationHelper

  #  View
  def link_to_new(link_source, remote = true, classes = "", texto = "")
    if texto == ""
      link_to "<i class='small material-icons right'>add_circle_outline</i> Novo".html_safe, link_source, remote: remote, class: "btn waves-effect waves-light #{classes}"
    else
      link_to "<i class='small material-icons right'>add_circle_outline</i> #{texto}".html_safe, link_source, remote: remote, class: "btn waves-effect waves-light #{classes}"
    end
  end

  def link_to_edit(link_source, remote = true)
    link_to '<i class="material-icons secondary-color-text">edit</i>'.html_safe, link_source, remote: remote, data: { tooltip:"Editar" }, class: 'tooltipped'
  end

  def link_to_destroy(object, classe = "", remote = true)
    link_to '<i class="material-icons secondary-color-text">delete</i>'.html_safe, object, remote: remote, method: :delete, data: { confirm: 'Tem certeza?', tooltip:"Excluir" }, class: "tooltipped #{classe}"
  end

  def link_to_icon(link_source, nome, icone, remote = false)
    link_to "<i class='small material-icons right'>#{icone}</i> #{nome}".html_safe, link_source, remote: remote, class:"waves-effect"
  end

  def material_check_box(ativo)
    ativo ? '<i class="material-icons secondary-color-text">check_box</i>' : '<i class="material-icons secondary-color-text">check_box_outline_blank</i>'
  end

  # Datatables
  def filtro_dt
    '<i class="material-icons right datatables-hr-filter">visibility</i>'.html_safe
  end
end
