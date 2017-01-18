class ClienteBancoDatatable < AjaxDatatablesRails::Base
  include ApplicationHelper

  def view_columns
    @view_columns ||= {
      banco_codigo: { source: "Banco.codigo", cond: :like },
      banco_nome: { source: "Banco.nome", cond: :like },
      agencia: { source: "ClienteBanco.agencia", cond: :like },
      conta_corrente: { source: "ClienteBanco.conta_corrente", cond: :like },
      cidade_nome: { source: "Cidade.nome", cond: :like },
      estado_sigla: { source: "Estado.sigla", cond: :like },
      correntista_nome: { source: "ClienteBanco.correntista_nome", cond: :like },
      correntista_cpf_cnpj: { source: "ClienteBanco.correntista_cpf_cnpj", cond: :like },
      observacao: { source: "ClienteBanco.observacao", cond: :like },
      created_at: { source: "ClienteBanco.created_at", cond: :like },
      primario: { source: "ClienteBanco.primario", cond: :like },
      ativo: { source: "ClienteBanco.ativo", cond: :like },
    }
  end

  private

  def data
    records.map do |record|
      {
        banco_codigo: record.banco.codigo,
        banco_nome: record.banco.nome,
        agencia: record.agencia,
        conta_corrente: record.conta_corrente,
        cidade_nome: record.cidade.nome,
        estado_sigla: record.cidade.estado.sigla,
        correntista_nome: record.correntista_nome,
        correntista_cpf_cnpj: record.correntista_cpf_cnpj,
        observacao: record.observacao,
        created_at: record.created_at.to_s(:data_formatada),
        primario: material_check_box(record.primario),
        ativo: material_check_box(record.ativo),
        DT_RowId: "cliente_banco_#{record.id}",
      }
    end
  end

  def get_raw_records
    ClienteBanco.joins(:banco, cidade: :estado).where(cliente_id: options[:cliente])
  end

  def permitido?
    options[:permitido]
  end
end
