class PagamentoCondicao < ApplicationRecord
  audited
  trimmed_fields :nome

  after_create :cria_parcelas
  after_update :altera_parcelas

  has_many :pagamento_parcelas, dependent: :destroy
  has_many :leiloes_elite, class_name: 'LeilaoPadrao', foreign_key: :pagamento_elite_id
  has_many :leiloes_corte, class_name: 'LeilaoPadrao', foreign_key: :pagamento_corte_id
  has_many :leiloes_outros, class_name: 'LeilaoPadrao', foreign_key: :pagamento_outros_id

  validates :nome, presence: true
  validates :tipo, presence: true
  validates :captacoes, presence: true
  validates :parcelas, presence: true
  validate :numero_de_parcelas_e_captacoes
  # validate :numero_de_captacoes

  enum tipo: { período_de_dias: 0, mensal: 1, datas_diferenciadas: 2 }

  accepts_nested_attributes_for :pagamento_parcelas, reject_if: :all_blank, allow_destroy: true

  def numero_de_parcelas_e_captacoes
    errors.add(:parcelas, "O número de parcelas não pode ser maior do que o número de captações.") if parcelas > captacoes
  end

  # def numero_de_captacoes
  #   errors.add(:captacoes, "O número de captações não confere.") unless captacoes_conferem? || new_record?
  # end
  #
  # def captacoes_conferem?
  #   unless new_record?
  #     puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
  #     puts "id: #{id}"
  #     puts "captacoes: #{captacoes}"
  #     puts "parcela_captacoes: #{parcela_captacoes}"
  #     puts "captacoes_was: #{captacoes_was}"
  #
  #     puts "________________________________"
  #     pagamento_parcelas.each do |parcela|
  #       puts "parcela.id: #{parcela.id}"
  #       puts "parcela.captacoes: #{parcela.captacoes}"
  #     end
  #   end
  #   captacoes == parcela_captacoes
  # end

  def parcela_captacoes
    pagamento_parcelas.sum(:captacoes)
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
