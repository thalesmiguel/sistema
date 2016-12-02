class EstadoDatatable < AjaxDatatablesRails::Base
  include ApplicationHelper

  def_delegators :@view, :link_to, :edit_estado_path

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= ['Estado.nome', 'Estado.sigla', 'Estado.created_at']
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= ['Estado.nome', 'Estado.sigla']
  end


  private

  def data
    records.map do |record|
      [
        record.nome,
        record.sigla,
        record.created_at.to_s(:data_formatada),
        "placeholder",
        "#{link_to_edit edit_estado_path(record) if permitido?}" "#{link_to_destroy record, 'excluir-estado' if permitido?}"
      ]
    end
  end

  def get_raw_records
    Estado.all
  end

  def permitido?
    options[:permitido]
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
