class PatrocinadorDatatable < ApplicationDatatable

  def view_columns
    @view_columns ||= {
      nome: { source: "Patrocinador.nome", cond: :like },
    }
  end

  private

  def data
    records.map do |record|
      {
        nome: record.nome,
        DT_RowId: "patrocinador_#{record.id}",
      }
    end
  end

  def get_raw_records
    Patrocinador.all
  end
end
