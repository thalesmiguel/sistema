class PagamentoParcela < ApplicationRecord
  audited

  before_update :apaga_vencimento, unless: Proc.new { |parcela| parcela.pagamento_condicao.datas_diferenciadas? if pagamento_condicao }

  belongs_to :pagamento_condicao, inverse_of: :pagamento_parcelas

  validates :parcela, presence: true
  validates :captacoes, presence: true
  validates :pagamento_condicao, presence: true
  validates :vencimento, presence: { message: "data de vencimento deve ser informada." }, if: Proc.new { |parcela| parcela.pagamento_condicao.datas_diferenciadas? if pagamento_condicao }

  def apaga_vencimento
    self.vencimento = nil
  end

end
