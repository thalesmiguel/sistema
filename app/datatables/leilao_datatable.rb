class LeilaoDatatable < ApplicationDatatable
  include ApplicationHelper

  def view_columns
    @view_columns ||= {
      nome: { source: "Leilao.nome", cond: :like },
      recinto: { source: "Leilao.nome", cond: :like },
      cidade_nome: { source: "Cidade.nome", cond: :like },
      estado_sigla: { source: "Estado.sigla", cond: :like },
      data_inicio: { source: "Leilao.data_inicio", cond: :like },
    }
  end

  private

  def data
    records.map do |record|
      {
        nome: record.nome,
        recinto: record.nome,
        cidade_nome: record.cidade_nome,
        estado_sigla: record.estado_sigla,
        data_inicio: record.data_inicio,

        DT_RowId: "leilao_#{record.id}",
      }
    end
  end

  def get_raw_records
    Leilao.left_outer_joins({ cidade: :estado })
      .select("leiloes.*, cidades.nome as 'cidade_nome', estados.sigla as 'estado_sigla'")
  end

  def filtra_cadastro_tipo
    ->(column) { column.table[column.field].eq(Leilao.cadastro_tipos[column.search.value]) }
  end
end
