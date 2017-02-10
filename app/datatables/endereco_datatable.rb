class EnderecoDatatable < ApplicationDatatable
  include ApplicationHelper

  def view_columns
    @view_columns ||= {
      tipo: { source: "Endereco.tipo", cond: filtra_tipo },
      logradouro: { source: "Endereco.logradouro", cond: :like },
      numero: { source: "Endereco.numero", cond: :like },
      complemento: { source: "Endereco.complemento", cond: :like },
      bairro: { source: "Endereco.bairro", cond: :like },
      cep: { source: "Endereco.cep", cond: :like },
      caixa_postal: { source: "Endereco.caixa_postal", cond: :like },
      cidade_nome: { source: "Cidade.nome", cond: :like },
      estado_sigla: { source: "Estado.sigla", cond: :like },
      ativo: { source: "Endereco.ativo", cond: filtra_check_box },
      primario: { source: "Endereco.primario", cond: filtra_check_box },
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
        ativo: boolean_pt(record.ativo),
        primario: boolean_pt(record.primario),
        DT_RowId: "endereco_#{record.id}",
      }
    end
  end

  def get_raw_records
    Endereco.joins(cidade: :estado).where(cliente_id: options[:cliente])
  end

  def filtra_tipo
    ->(column) { column.table[column.field].eq(Endereco.tipos[column.search.value.downcase]) }
  end
end
