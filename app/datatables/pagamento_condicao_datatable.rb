class PagamentoCondicaoDatatable < ApplicationDatatable

  def view_columns
    @view_columns ||= {
      nome: { source: "PagamentoCondicao.nome", cond: :like },
      tipo: { source: "PagamentoCondicao.tipo", cond: filtra_tipo },
      parcelas: { source: "PagamentoCondicao.parcelas", cond: :like },
      captacoes: { source: "PagamentoCondicao.captacoes", cond: :like },
      frequencia: { source: "PagamentoCondicao.frequencia", cond: :like },
      entrada: { source: "PagamentoCondicao.entrada", cond: filtra_check_box },
    }
  end

  private

  def data
    records.map do |record|
      {
        nome: record.nome,
        tipo: record.tipo.titleize,
        parcelas: record.parcelas,
        captacoes: record.captacoes,
        frequencia: record.frequencia,
        entrada: boolean_pt(record.entrada),
        DT_RowId: "pagamento_condicao_#{record.id}",
      }
    end
  end

  def get_raw_records
    PagamentoCondicao.all
  end

  def filtra_tipo
    ->(column) { column.table[column.field].eq(PagamentoCondicao.tipos[column.search.value.untitleize]) }
  end
end
