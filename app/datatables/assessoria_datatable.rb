class AssessoriaDatatable < ApplicationDatatable

  def view_columns
    @view_columns ||= {
      nome: { source: "Assessoria.nome", cond: :like },
    }
  end

  private

  def data
    records.map do |record|
      {
        nome: record.nome,
        DT_RowId: "assessoria_#{record.id}",
      }
    end
  end

  def get_raw_records
    Assessoria.all
  end
end
