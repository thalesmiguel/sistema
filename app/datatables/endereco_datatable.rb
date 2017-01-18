class EnderecoDatatable < AjaxDatatablesRails::Base
  include ApplicationHelper

  def view_columns
    @view_columns ||= {
      tipo: { source: "Endereco.tipo", cond: :like },
      logradouro: { source: "Endereco.logradouro", cond: :like },
      numero: { source: "Endereco.numero", cond: :like },
      complemento: { source: "Endereco.complemento", cond: :like },
      bairro: { source: "Endereco.bairro", cond: :like },
      cep: { source: "Endereco.cep", cond: :like },
      caixa_postal: { source: "Endereco.caixa_postal", cond: :like },
      cidade_nome: { source: "Cidade.nome", cond: :like },
      estado_sigla: { source: "Estado.sigla", cond: :like },
      ativo: { source: "Endereco.ativo", cond: :like },
      primario: { source: "Endereco.primario", cond: :like },
    }
  end

  private

  def data
    records.map do |record|
      {
        tipo: record.tipo.humanize,
        logradouro: record.logradouro,
        numero: record.numero,
        complemento: record.complemento,
        bairro: record.bairro,
        cep: record.cep,
        caixa_postal: record.caixa_postal,
        cidade_nome: record.cidade.nome,
        estado_sigla: record.cidade.estado.sigla,
        ativo: material_check_box(record.ativo),
        primario: material_check_box(record.primario),
        DT_RowId: "endereco_#{record.id}",
      }
    end
  end

  def get_raw_records
    Endereco.joins(cidade: :estado).where(cliente_id: options[:cliente])
  end

  def permitido?
    options[:permitido]
  end
end
