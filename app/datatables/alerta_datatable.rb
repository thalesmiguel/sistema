class AlertaDatatable < AjaxDatatablesRails::Base
  include ApplicationHelper

  def_delegators :@view

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= ['Alerta.tipo', 'Alerta.descricao', 'Alerta.ativo']
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= ['Alerta.tipo', 'Alerta.descricao', 'Alerta.ativo']
  end


  private

  def data
    records.map do |record|
      {
        '0': record.tipo,
        '1': record.created_at.to_s(:data_formatada),
        '2': record.descricao,
        '3': material_check_box(record.ativo),
        '4': 0,
        '5': "usuario",

        'DT_RowId' => "alerta_#{record.id}",
        'DT_RowClass': "bozo",
      }
    end
  end

  def get_raw_records
    # Alerta.all
    options[:alertas]
  end

  def permitido?
    options[:permitido]
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
