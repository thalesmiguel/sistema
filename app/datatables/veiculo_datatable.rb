class VeiculoDatatable < ApplicationDatatable

  def view_columns
    @view_columns ||= {
      modelo: { source: "Veiculo.modelo", cond: :like },
      ano: { source: "Veiculo.ano", cond: :eq },
      placa: { source: "Veiculo.placa", cond: :like },
      combustivel: { source: "Veiculo.combustivel", cond: filtra_combustivel },
      ocupantes: { source: "Veiculo.ocupantes", cond: :eq },
      media: { source: "Veiculo.media", cond: :like },
      disponivel_viagem: { source: "Veiculo.disponivel_viagem", cond: filtra_check_box },
    }
  end

  private

  def data
    records.map do |record|
      {
        modelo: record.modelo,
        ano: record.ano,
        placa: record.placa,
        combustivel: record.combustivel,
        ocupantes: record.ocupantes,
        media: record.media,
        disponivel_viagem: boolean_pt(record.disponivel_viagem),
        DT_RowId: "veiculo_#{record.id}",
      }
    end
  end

  def get_raw_records
    Veiculo.all
  end

  def filtra_combustivel
    ->(column) { column.table[column.field].eq(Veiculo.combustiveis[column.search.value]) }
  end
end
