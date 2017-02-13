class BandeiraDatatable < ApplicationDatatable

  def view_columns
    @view_columns ||= {
      nome: { source: "Bandeira.nome", cond: :like },
      sigla: { source: "Bandeira.sigla", cond: :like },
    }
  end

  private

  def data
    records.map do |record|
      {
        nome: record.nome,
        sigla: record.sigla,
        DT_RowId: "bandeira_#{record.id}",
      }
    end
  end

  def get_raw_records
    Bandeira.all
  end
end
