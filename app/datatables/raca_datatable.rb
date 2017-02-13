class RacaDatatable < ApplicationDatatable

  def view_columns
    @view_columns ||= {
      nome: { source: "Raca.nome", cond: :like },
      especie: { source: "Raca.especie", cond: filtra_epecie },
    }
  end

  private

  def data
    records.map do |record|
      {
        nome: record.nome,
        especie: record.especie,
        DT_RowId: "raca_#{record.id}",
      }
    end
  end

  def get_raw_records
    Raca.all
  end

  def filtra_epecie
    ->(column) { column.table[column.field].eq(Raca.especies[column.search.value]) }
  end
end
