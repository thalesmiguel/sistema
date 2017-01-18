class BancoDatatable < AjaxDatatablesRails::Base

  def view_columns
    @view_columns ||= {
      codigo: { source: "Banco.codigo", cond: :like },
      nome: { source: "Banco.nome", cond: :like },
    }
  end

  private

  def data
    records.map do |record|
      {
        codigo: record.codigo,
        nome: record.nome,
        DT_RowId: "banco_#{record.id}",
      }
    end
  end

  def get_raw_records
    Banco.all
  end

  def permitido?
    options[:permitido]
  end
end
