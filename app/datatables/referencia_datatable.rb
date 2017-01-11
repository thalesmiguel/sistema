class ReferenciaDatatable < AjaxDatatablesRails::Base
  include ApplicationHelper

  def_delegators :@view

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= ['Referencia.nome', 'Referencia.telefone', 'Referencia.observacao']
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= ['Referencia.nome', 'Referencia.telefone', 'Referencia.observacao']
  end


  private

  def data
    records.map do |record|
      {
        '0': record.nome,
        '1': record.telefone,
        '2': record.observacao,

        'DT_RowId' => "referencia_#{record.id}",
      }
    end
  end

  def get_raw_records
    # Referencia.all
    options[:referencias]
  end

  def permitido?
    options[:permitido]
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
