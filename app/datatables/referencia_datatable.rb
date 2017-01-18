class ReferenciaDatatable < AjaxDatatablesRails::Base

  def view_columns
    @view_columns ||= {
      nome: { source: "Referencia.nome", cond: :like },
      telefone: { source: "Referencia.telefone", cond: :like },
      observacao: { source: "Referencia.observacao", cond: :like },
    }
  end

  private

  def data
    records.map do |record|
      {
        nome: record.nome,
        telefone: record.telefone,
        observacao: record.observacao,
        DT_RowId: "referencia_#{record.id}",
      }
    end
  end

  def get_raw_records
    Referencia.where(cliente_id: options[:cliente])
  end

  def permitido?
    options[:permitido]
  end
end
