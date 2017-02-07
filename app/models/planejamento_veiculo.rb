class PlanejamentoVeiculo < ApplicationRecord
  audited
  trimmed_fields :observacao

  belongs_to :leilao
  belongs_to :veiculo

  has_many :planejamento_viagens, dependent: :destroy
  has_many :planejamento_escalas, through: :planejamento_viagens

  validates :leilao, presence: true
  validates :veiculo, presence: true
  validate :veiculo_deve_estar_disponivel_para_viagem

  def veiculo_deve_estar_disponivel_para_viagem
    errors.add(:veiculo, 'deve estar disponível para viagem') unless veiculo.disponivel_viagem? if veiculo 
  end

  # def funcionario_deve_estar_na_escala
  #   leilao.planejamento_escala.funcionario
  # end

end
