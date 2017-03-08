class LeilaoDatatable < ApplicationDatatable

  def view_columns
    @view_columns ||= {
      nome: { source: "Leilao.nome", cond: :like },
      evento: { source: "Leilao.nome", cond: :like },
      recinto: { source: "Leilao.nome", cond: :like },
      cidade_nome: { source: "Cidade.nome", cond: :like },
      estado_sigla: { source: "Estado.sigla", cond: :like },
      data_inicio: { source: "Leilao.data_inicio", cond: filtra_data },
      hora_inicio: { source: "Leilao.data_inicio", cond: filtra_hora },
      categoria: { source: "Leilao.categoria", cond: filtra_categoria },
    }
  end

  private

  def data
    records.map do |record|
      {
        nome: record.nome,
        evento: record.nome,
        recinto: record.nome,
        cidade_nome: record.cidade_nome,
        estado_sigla: record.estado_sigla,
        data_inicio: record.try(:data_inicio).try(:to_time).try(:to_s),
        hora_inicio: record.try(:data_inicio).try(:to_time).try(:to_s, :time),
        categoria: record.categoria.titleize,

        DT_RowId: "leilao_#{record.id}",
        DT_RowClass: record.categoria,
      }
    end
  end

  def get_raw_records
    if options[:id] == ''
      Leilao.left_outer_joins({ cidade: :estado })
        .select("leiloes.*, cidades.nome as 'cidade_nome', estados.sigla as 'estado_sigla'")
        .order(data_inicio: :desc)
    else
      Leilao.left_outer_joins({ cidade: :estado })
        .select("leiloes.*, cidades.nome as 'cidade_nome', estados.sigla as 'estado_sigla'")
        .where.not(id: options[:id])
        .order(data_inicio: :desc)
    end
  end

  def filtra_categoria
    ->(column) { column.table[column.field].eq(Leilao.categorias[column.search.value.downcase]) }
  end
end
