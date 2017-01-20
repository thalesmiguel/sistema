class LancarAutorizadoDatatable < AjaxDatatablesRails::Base
  include ApplicationHelper

  def view_columns
    @view_columns ||= {
      nome: { source: "LancarAutorizado.nome", cond: :like },
      cpf: { source: "LancarAutorizado.cpf", cond: :like },
      tem_procuracao: { source: "LancarAutorizado.tem_procuracao", cond: :like },
      observacao: { source: "LancarAutorizado.observacao", cond: :like },
      ativo: { source: "LancarAutorizado.ativo", cond: :like },
    }
  end

  private

  def data
    records.map do |record|
      {
        nome: record.nome,
        cpf: record.cpf,
        tem_procuracao: material_check_box(record.tem_procuracao),
        observacao: record.observacao,
        ativo: material_check_box(record.ativo),
        DT_RowId: "lancar_autorizado_#{record.id}",
      }
    end
  end

  def get_raw_records
    LancarAutorizado.where(cliente_id: options[:cliente])
  end

  def permitido?
    options[:permitido]
  end
end
