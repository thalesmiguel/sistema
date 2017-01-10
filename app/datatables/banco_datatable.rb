class BancoDatatable < AjaxDatatablesRails::Base
  include ApplicationHelper

  def_delegators :@view, :link_to, :edit_banco_path

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= ['Banco.codigo', 'Banco.nome']
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= ['Banco.codigo', 'Banco.nome']
  end


  private

  def data
    records.map do |record|
      [
        record.codigo,
        record.nome,
        "#{link_to_edit edit_banco_path(record) if permitido?}" "#{link_to_destroy record, 'excluir-banco' if permitido?}"
      ]
    end
  end

  def get_raw_records
    Banco.all
  end

  def permitido?
    options[:permitido]
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
