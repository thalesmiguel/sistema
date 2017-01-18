class EstadoDatatable < AjaxDatatablesRails::Base

  def view_columns
    @view_columns ||= {
      nome: { source: "Estado.nome", cond: :like },
      sigla: { source: "Estado.sigla", cond: :like },
    }
  end

  private

  def data
    records.map do |record|
      {
        nome: record.nome,
        sigla: record.sigla,
        created_at: record.created_at.to_s(:data_formatada),
        created_by: record.audits.first.user.username,
        updated_at: record.updated_at.to_s(:data_formatada),
        updated_by: record.audits.last.user.username,
        DT_RowId: "estado_#{record.id}",
      }
    end
  end

  def get_raw_records
    Estado.all
  end

  def permitido?
    options[:permitido]
  end
end
