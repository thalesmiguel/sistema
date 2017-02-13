class FuncaoDatatable < ApplicationDatatable

  def view_columns
    @view_columns ||= {
      nome: { source: "Funcao.nome", cond: :like },
      created_at: { source: "Funcao.created_at", cond: filtra_data },
      updated_at: { source: "Funcao.updated_at", cond: filtra_data },
    }
  end

  private

  def data
    records.map do |record|
      {
        nome: record.nome,
        created_at: record.created_at.to_s(:data_formatada),
        updated_at: record.updated_at.to_s(:data_formatada),
        DT_RowId: "funcao_#{record.id}",
      }
    end
  end

  def get_raw_records
    Funcao.all
  end
end
