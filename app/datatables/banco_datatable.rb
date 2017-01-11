class BancoDatatable < AjaxDatatablesRails::Base
  include ApplicationHelper

  def_delegators :@view

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
      {
        '0': record.codigo,
        '1': record.nome,

        'DT_RowId' => "banco_#{record.id}",
      }
    end
  end

  def get_raw_records
    # Banco.all
    options[:bancos]
  end

  def permitido?
    options[:permitido]
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
