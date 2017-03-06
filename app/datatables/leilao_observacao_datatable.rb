class LeilaoObservacaoDatatable < ApplicationDatatable

  def view_columns
    @view_columns ||= {
      created_at: { source: "LeilaoObservacao.created_at", cond: :like },
      descricao: { source: "LeilaoObservacao.descricao", cond: :like },
      ativo: { source: "LeilaoObservacao.ativo", cond: filtra_check_box },
    }
  end

  private


  def data
    records.map do |record|
      {
        created_at: record.created_at.to_s(:data_formatada),
        descricao: record.descricao,
        ativo: boolean_pt(record.ativo),
        DT_RowId: "leilao_observacao_#{record.id}",
      }
    end
  end

  def get_raw_records
    LeilaoObservacao.where(leilao_id: options[:leilao])
  end
end
