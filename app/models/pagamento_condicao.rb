class PagamentoCondicao < ApplicationRecord
  audited
  trimmed_fields :codigo, :nome

  has_many :pagamento_parcelas
  # has_many :leilao_bandeiras
  # has_many :bandeira_leiloes, through: :leilao_bandeiras, source: :leilao

  validates :codigo, presence: true
  validates :nome, presence: true
  validates :tipo, presence: true
  validate :numero_de_parcelas_e_captacoes

  enum tipo: { período_de_dias: 0, mensal: 1, datas_diferenciadas: 2 }

  def numero_de_parcelas_e_captacoes
    parcelas > captacoes ? errors.add(:parcelas, "O número de parcelas não pode ser menor do que o número de captações.") : true
  end

end
