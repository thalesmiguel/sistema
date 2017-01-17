class AlertaComentarioDatatable < AjaxDatatablesRails::Base
  include ApplicationHelper

  def_delegators :@view

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= ['AlertaComentario.created_at', 'AlertaComentario.descricao']
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= ['AlertaComentario.created_at', 'AlertaComentario.descricao']
  end


  private

  def data
    records.map do |record|
      {
        '0': record.created_at.to_s(:data_formatada),
        '1': record.descricao,

        'DT_RowId' => "alerta_comentario_#{record.id}",
      }
    end
  end

  def get_raw_records
    # AlertaComentario.all
    options[:alerta_comentarios]
  end

  def permitido?
    options[:permitido]
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
