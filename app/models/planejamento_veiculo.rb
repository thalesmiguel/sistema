class PlanejamentoVeiculo < ApplicationRecord
  audited
  trimmed_fields :observacao

  belongs_to :leilao
  # belongs_to :funcionario, class_name: 'Cliente'
  belongs_to :veiculo

  validates :leilao, presence: true
  validates :veiculo, presence: true
  validate :veiculo_deve_estar_disponivel_para_viagem

  def veiculo_deve_estar_disponivel_para_viagem
    !veiculo.disponivel_viagem? ? errors.add(:veiculo, 'deve estar disponível para viagem') : true if veiculo
  end

  # def funcionario_deve_estar_na_escala
  #   leilao.planejamento_escala.funcionario
  # end

end
