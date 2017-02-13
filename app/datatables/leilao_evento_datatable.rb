class LeilaoEventoDatatable < ApplicationDatatable

  def view_columns
    @view_columns ||= {
      nome: { source: "LeilaoEvento.nome", cond: :like },
      data_inicio: { source: "LeilaoEvento.data_inicio", cond: filtra_data },
      data_fim: { source: "LeilaoEvento.data_fim", cond: filtra_data },
    }
  end

  private

  def data
    records.map do |record|
      {
        nome: record.nome,
        data_inicio: record.data_inicio.to_s(:data_formatada),
        data_fim: record.data_fim.to_s(:data_formatada),
        DT_RowId: "leilao_evento_#{record.id}",
      }
    end
  end

  def get_raw_records
    LeilaoEvento.all
  end
end
