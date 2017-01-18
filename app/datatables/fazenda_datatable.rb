class FazendaDatatable < AjaxDatatablesRails::Base
  include ApplicationHelper

  def view_columns
    @view_columns ||= {
      nome: { source: "Fazenda.nome", cond: :like },
      cidade_nome: { source: "Cidade.nome", cond: :like },
      estado_sigla: { source: "Estado.sigla", cond: :like },
      inscricao_estadual: { source: "Fazenda.inscricao_estadual", cond: :like },
      cnpj_produtor: { source: "Fazenda.cnpj_produtor", cond: :like },
      cnpj_fazenda: { source: "Fazenda.cnpj_fazenda", cond: :like },
      ativo: { source: "Fazenda.ativo", cond: :like },
    }
  end

  private

  def data
    records.map do |record|
      {
        nome: record.nome,
        cidade_nome: record.cidade.nome,
        estado_sigla: record.cidade.estado.sigla,
        inscricao_estadual: record.inscricao_estadual,
        cnpj_produtor: record.cnpj_fazenda,
        cnpj_fazenda: record.cnpj_produtor,
        ativo: material_check_box(record.ativo),
        fazenda_vendas: 0,
        fazenda_compras: 0,
        DT_RowId: "fazenda_#{record.id}",
      }
    end
  end

  def get_raw_records
    Fazenda.joins(cidade: :estado).where(cliente_id: options[:cliente])
  end

  def permitido?
    options[:permitido]
  end
end
