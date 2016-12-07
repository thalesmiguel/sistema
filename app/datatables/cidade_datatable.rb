class CidadeDatatable < AjaxDatatablesRails::Base
  include ApplicationHelper

  def_delegators :@view, :link_to, :edit_cidade_path

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= ['Cidade.nome', 'Estado.sigla']
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= ['Cidade.nome', 'Estado.sigla']
  end


  private

  def data
    records.map do |record|
      [
        record.nome,
        record.estado.sigla,
        record.created_at.to_s(:data_formatada),
        record.audits.first.user.username,
        record.updated_at.to_s(:data_formatada),
        record.audits.last.user.username,
        "#{link_to_edit edit_cidade_path(record) if permitido?}" "#{link_to_destroy record, 'excluir-cidade' if permitido?}"
      ]
    end
  end

  def get_raw_records
    Cidade.joins(:estado).order("estados.sigla")
  end

  def permitido?
    options[:permitido]
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
