class SubtipoDatatable < ApplicationDatatable

  def view_columns
    @view_columns ||= {
      id: { source: "Subtipo.id", cond: :like },
      nome: { source: "Subtipo.nome", cond: :like },
    }
  end

  private

  def data
    records.map do |record|
      {
        id: record.id,
        nome: record.nome,
        DT_RowId: "subtipo_#{record.id}",
      }
    end
  end

  def get_raw_records
    Subtipo.all
  end
end
