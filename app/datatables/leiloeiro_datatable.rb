class LeiloeiroDatatable < ApplicationDatatable

  def view_columns
    @view_columns ||= {
      nome_contrato: { source: "Leiloeiro.nome_contrato", cond: :like },
      razao_social: { source: "Leiloeiro.razao_social", cond: :like },
      comissao_elite: { source: "Leiloeiro.comissao_elite", cond: :like },
      comissao_corte: { source: "Leiloeiro.comissao_corte", cond: :like },
      comissao_virtual: { source: "Leiloeiro.comissao_virtual", cond: :like },
      comissao_shopping: { source: "Leiloeiro.comissao_shopping", cond: :like },
    }
  end

  private

  def data
    records.map do |record|
      {
        nome_contrato: record.nome_contrato,
        razao_social: record.razao_social,
        comissao_elite: record.comissao_elite,
        comissao_corte: record.comissao_corte,
        comissao_virtual: record.comissao_virtual,
        comissao_shopping: record.comissao_shopping,
        DT_RowId: "leiloeiro_#{record.id}",
      }
    end
  end

  def get_raw_records
    Leiloeiro.all
  end
end
