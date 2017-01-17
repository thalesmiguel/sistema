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
        '0': record.tipo.humanize,
        '1': record.created_at.to_s(:data_formatada),
        '2': record.descricao,
        '3': material_check_box(record.ativo),
        '4': record.alerta_comentarios.count,
        '5': record.user.username,

        'DT_RowId' => "alerta_#{record.id}",
        'DT_RowClass': record.tipo,
      }
    end
  end

  def get_raw_records
    # Alerta.all
    if options[:somente_ativos] == "false"
      options[:alertas]
    else
      options[:alertas].ativo
    end
  end

  def permitido?
    options[:permitido]
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
