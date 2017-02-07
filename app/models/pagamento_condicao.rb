class PagamentoCondicao < ApplicationRecord
  audited
  trimmed_fields :codigo, :nome

  after_create :cria_parcelas

  has_many :pagamento_parcelas, dependent: :destroy
  has_many :leiloes_elite, class_name: 'LeilaoPadrao', foreign_key: :pagamento_elite_id
  has_many :leiloes_corte, class_name: 'LeilaoPadrao', foreign_key: :pagamento_corte_id
  has_many :leiloes_outros, class_name: 'LeilaoPadrao', foreign_key: :pagamento_outros_id

  validates :codigo, presence: true
  validates :nome, presence: true
  validates :tipo, presence: true
  validate :numero_de_parcelas_e_captacoes

  enum tipo: { período_de_dias: 0, mensal: 1, datas_diferenciadas: 2 }


  def numero_de_parcelas_e_captacoes
    errors.add(:parcelas, "O número de parcelas não pode ser menor do que o número de captações.") if parcelas > captacoes
  end

  def captacoes_conferem?
    captacoes == pagamento_parcelas.sum(:captacoes)
  end

  def cria_parcelas
    parcelas.times do |n|
      if datas_diferenciadas?
        pagamento_parcelas.create!(parcela: n+1, captacoes: 0, vencimento: Time.zone.now)
      else
        pagamento_parcelas.create!(parcela: n+1, captacoes: 0)
      end
    end
  end

  def utilizado_em
    leiloes_elite.or(leiloes_corte).or(leiloes_outros)
  end

end
