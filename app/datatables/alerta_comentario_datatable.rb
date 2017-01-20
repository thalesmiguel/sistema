class AlertaComentarioDatatable < AjaxDatatablesRails::Base

  def view_columns
    @view_columns ||= {
      created_at: { source: "AlertaComentario.created_at", cond: :like },
      descricao: { source: "AlertaComentario.descricao", cond: :like },
    }
  end

  private


  def data
    records.map do |record|
      {
        created_at: record.created_at.to_s(:data_formatada),
        descricao: record.descricao,
        DT_RowId: "alerta_comentario_#{record.id}",
      }
    end
  end

  def get_raw_records
    AlertaComentario.where(alerta_id: options[:alerta])
  end

  def permitido?
    options[:permitido]
  end
end
