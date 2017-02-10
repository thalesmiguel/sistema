class CidadeDatatable < ApplicationDatatable

  def view_columns
    @view_columns ||= {
      nome: { source: "Cidade.nome", cond: :like },
      estado_sigla: { source: "Estado.sigla", cond: :like },
      created_at: { source: "Cidade.created_at", cond: :like },
      updated_at: { source: "Cidade.updated_at", cond: :like },
    }
  end

  private

  def data
    records.map do |record|
      {
        nome: record.nome,
        estado_sigla: record.estado.sigla,
        created_at: record.created_at.to_s(:data_formatada),
        created_by: record.audits.first.user.username,
        updated_at: record.updated_at.to_s(:data_formatada),
        updated_by: record.audits.last.user.username,
        DT_RowId: "cidade_#{record.id}",
      }
    end
  end

  def get_raw_records
    Cidade.joins(:estado)
  end
end
