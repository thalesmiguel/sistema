module ApplicationHelper

  def link_to_new(link_source, remote = true)
    link_to "<i class='small material-icons right'>add_circle_outline</i> Novo".html_safe, link_source, remote: remote, class: 'btn waves-effect waves-light'
  end

  def link_to_edit(link_source, remote = true)
    link_to '<i class="material-icons secondary-color-text">edit</i>'.html_safe, link_source, remote: remote, data: { tooltip:"Editar" }, class: 'tooltipped'
  end

  def link_to_destroy(object, classe = "", remote = true)
    link_to '<i class="material-icons secondary-color-text">delete</i>'.html_safe, object, remote: remote, method: :delete, data: { confirm: 'Tem certeza?', tooltip:"Excluir" }, class: "tooltipped #{classe}"
  end
end
