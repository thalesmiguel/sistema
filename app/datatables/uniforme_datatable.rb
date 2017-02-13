class UniformeDatatable < ApplicationDatatable

  def view_columns
    @view_columns ||= {
      nome: { source: "Uniforme.nome", cond: :like },
      sexo: { source: "Uniforme.sexo", cond: filtra_sexo },
      created_at: { source: "Uniforme.created_at", cond: filtra_data },
      updated_at: { source: "Uniforme.updated_at", cond: filtra_data },
    }
  end

  private

  def data
    records.map do |record|
      {
        nome: record.nome,
        sexo: record.sexo,
        created_at: record.created_at.to_s(:data_formatada),
        updated_at: record.updated_at.to_s(:data_formatada),
        DT_RowId: "uniforme_#{record.id}",
      }
    end
  end

  def get_raw_records
    Uniforme.all
  end

  def filtra_sexo
    ->(column) { column.table[column.field].eq(Uniforme.sexos[column.search.value]) }
  end
end
