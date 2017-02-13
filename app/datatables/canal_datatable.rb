class CanalDatatable < ApplicationDatatable

  def view_columns
    @view_columns ||= {
      nome: { source: "Canal.nome", cond: :like },
    }
  end

  private

  def data
    records.map do |record|
      {
        nome: record.nome,
        DT_RowId: "canal_#{record.id}",
      }
    end
  end

  def get_raw_records
    Canal.all
  end
end
