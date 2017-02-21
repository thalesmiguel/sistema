class PagamentoCondicao < ApplicationRecord
  audited
  trimmed_fields :nome

  after_create :cria_parcelas
  after_update :altera_parcelas
  before_update :parcela_update!


  has_many :pagamento_parcelas, dependent: :destroy, inverse_of: :pagamento_condicao
  accepts_nested_attributes_for :pagamento_parcelas, reject_if: :all_blank, allow_destroy: true
  validates_associated :pagamento_parcelas

  has_many :leiloes_elite, class_name: 'LeilaoPadrao', foreign_key: :pagamento_elite_id
  has_many :leiloes_corte, class_name: 'LeilaoPadrao', foreign_key: :pagamento_corte_id
  has_many :leiloes_outros, class_name: 'LeilaoPadrao', foreign_key: :pagamento_outros_id

  validates :nome, presence: true
  validates :tipo, presence: true
  validates :captacoes, presence: true
  validates :parcelas, presence: true
  validates :frequencia, presence: true, if: :período_de_dias?

  validate :numero_de_parcelas_maior_que_o_de_captacoes
  validate :numero_de_captacoes

  enum tipo: { mensal: 0, datas_diferenciadas: 1, período_de_dias: 2 }


  def parcela_update!
    pagamento_parcelas.find_each(batch_size: 100) do |parcela|
      parcela.update(vencimento: nil)
    end
  end

  def apaga_vencimento
    pagamento_parcelas.update_all(vencimento: nil) unless datas_diferenciadas? if pagamento_parcelas
  end

  def numero_de_parcelas_maior_que_o_de_captacoes
    errors.add(:parcelas, "O número de parcelas não pode ser maior do que o número de captações.") if parcelas > captacoes
  end

  def numero_de_captacoes
    errors.add(:captacoes, "O número de captações não confere.") unless captacoes_conferem? || new_record?
  end

  def captacoes_conferem?
    self.captacoes == parcela_captacoes
  end

  def parcela_captacoes
    pagamento_parcelas.map { |v| v[:captacoes] }.reduce(0, :+)
  end

  def cria_parcelas
    parcelas.times do |n|
      pagamento_parcelas.create!(parcela: n+1, captacoes: (self.captacoes / self.parcelas), vencimento: (Time.zone.now if datas_diferenciadas?))
    end
  end

  def altera_parcelas
    if parcelas_changed?
      pagamento_parcelas.destroy_all
      cria_parcelas
    end
  end

  def utilizado_em
    leiloes_elite.or(leiloes_corte).or(leiloes_outros)
  end

end
