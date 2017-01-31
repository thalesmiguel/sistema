class PagamentoParcela < ApplicationRecord
  audited

  belongs_to :pagamento_condicao

  validates :parcela, presence: true
  validates :captacoes, presence: true
  validates :pagamento_condicao, presence: true
  # validates :vencimento, presence: true, if: pagamento_condicao.datas_diferenciadas?

  validate :quantidade_de_captacoes_deve_ser_igual_as_captacoes_da_condicao

  def quantidade_de_captacoes_deve_ser_igual_as_captacoes_da_condicao
    ultima_parcela? && !captacoes_conferem? ? errors.add(:captacoes, "A quantidade de captações está incorreta.") : true
  end

  def ultima_parcela?
    parcela == pagamento_condicao.parcelas if pagamento_condicao
  end

  def captacoes_conferem?
    puts captacoes
    puts captacao_atual
    puts "\n"
    puts pagamento_condicao.captacoes
    puts "__________________"

    (captacoes + captacao_atual) == pagamento_condicao.captacoes if captacoes
  end

  def captacao_atual
    PagamentoParcela.where(pagamento_condicao: pagamento_condicao).where.not(id: id).sum(:captacoes)
  end

end
