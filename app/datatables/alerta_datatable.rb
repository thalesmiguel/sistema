class AlertaDatatable < AjaxDatatablesRails::Base
  include ApplicationHelper

  def view_columns
    @view_columns ||= {
      tipo: { source: "Alerta.tipo", cond: :like },
      created_at: { source: "Alerta.created_at", cond: :like },
      descricao: { source: "Alerta.descricao", cond: :like },
      ativo: { source: "Alerta.ativo", cond: :like }
    }
  end

  private

  def data
    records.map do |record|
      {
        tipo: record.tipo.humanize,
        created_at: record.created_at.to_s(:data_formatada),
        descricao: record.descricao,
        ativo: material_check_box(record.ativo),
        qtde_comentarios: record.alerta_comentarios.count,
        created_by: record.user.username,
        DT_RowId: "alerta_#{record.id}",
        DT_RowClass: record.tipo,
      }
    end
  end

  def get_raw_records
    Alerta.includes(:alerta_comentarios, :user).where(cliente_id: options[:cliente]).order(:created_at)
  end

  def permitido?
    options[:permitido]
  end
end
