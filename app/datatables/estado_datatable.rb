class EstadoDatatable < ApplicationDatatable

  def view_columns
    @view_columns ||= {
      nome: { source: "Estado.nome", cond: :like },
      sigla: { source: "Estado.sigla", cond: :like },
      created_at: { source: "Estado.created_at", cond: filtra_data },
      updated_at: { source: "Estado.updated_at", cond: filtra_data },
    }
  end

  private

  def data
    records.map do |record|
      {
        nome: record.nome,
        sigla: record.sigla,
        created_at: record.created_at.to_s(:data_formatada),
        created_by: created_by(record),
        updated_at: record.updated_at.to_s(:data_formatada),
        updated_by: updated_by(record),
        DT_RowId: "estado_#{record.id}",
      }
    end
  end

  def get_raw_records
    Estado.all
  end

  def created_by(record)
    record.audits.first.user.username unless record.audits.first.nil?
  end

  def updated_by(record)
    record.audits.last.user.username unless record.audits.last.nil?
  end
end
