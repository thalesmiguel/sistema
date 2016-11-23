class EstadoDatatable < AjaxDatatablesRails::Base

  def_delegators :@view, :link_to, :edit_estado_path

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= ['estados.nome', 'estados.sigla', 'estados.created_at']
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= ['estados.nome', 'estados.sigla']
  end


  private

  def data
    records.map do |record|
      [
        record.nome,
        record.sigla,
        record.created_at,
        "criado por",
        "#{link_to('<i class="material-icons secondary-color-text">edit</i>'.html_safe, edit_estado_path(record), remote: true, data: { tooltip:"Editar" }, class: 'tooltipped')}" "#{link_to('<i class="material-icons secondary-color-text">delete</i>'.html_safe, record, remote: true, method: :delete, data: { confirm: 'Tem certeza?', tooltip:"Excluir" }, class: 'tooltipped estado-excluir')}"
      ]
    end
  end

  def get_raw_records
    Estado.all
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
