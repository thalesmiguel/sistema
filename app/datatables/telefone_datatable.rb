class TelefoneDatatable < AjaxDatatablesRails::Base
  include ApplicationHelper

  def view_columns
    @view_columns ||= {
      tipo: { source: "Telefone.tipo", cond: :like },
      ddi: { source: "Telefone.ddi", cond: :like },
      ddd: { source: "Telefone.ddd", cond: :like },
      numero: { source: "Telefone.numero", cond: :like },
      created_at: { source: "Telefone.created_at", cond: :like },
      ramal: { source: "Telefone.ramal", cond: :like },
      nome_contato: { source: "Telefone.nome_contato", cond: :like },
      importancia: { source: "Telefone.importancia", cond: :like },
      telemarketing: { source: "Telefone.telemarketing", cond: :like },
      divulgar: { source: "Telefone.divulgar", cond: :like },
      ativo: { source: "Telefone.ativo", cond: :like },
    }
  end

  private

  def data
    records.map do |record|
      {
        tipo: record.tipo.humanize,
        ddi: record.ddi,
        ddd: record.ddd,
        numero: record.numero,
        created_at: record.created_at.to_s(:data_formatada),
        ramal: record.ramal,
        nome_contato: record.nome_contato,
        importancia: record.importancia,
        telemarketing: material_check_box(record.telemarketing),
        divulgar: material_check_box(record.divulgar),
        ativo: material_check_box(record.ativo),
        DT_RowId: "telefone_#{record.id}",
      }
    end
  end

  def get_raw_records
    Telefone.where(cliente_id: options[:cliente])
  end

  def permitido?
    options[:permitido]
  end
end
