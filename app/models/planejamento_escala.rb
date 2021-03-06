class PlanejamentoEscala < ApplicationRecord
  audited
  trimmed_fields :diaria_descricao, :despesa_descricao, :avaliacao_observacao

  belongs_to :leilao
  belongs_to :funcionario, class_name: 'Cliente'
  belongs_to :funcao
  belongs_to :uniforme

  has_many :planejamento_viagens, dependent: :destroy
  has_many :planejamento_veiculos, through: :planejamento_viagens

  monetize :diaria_valor_centavos
  monetize :despesa_valor_centavos

  validates :leilao, presence: true
  validates :funcionario, presence: true
  validate :cliente_deve_ser_funcionario
  validate :sexo_do_uniforme_igual_ao_do_funcionario

  def cliente_deve_ser_funcionario
    errors.add(:funcionario, 'deve ser um funcionário') unless funcionario.funcionário? if funcionario
  end

  def sexo_do_uniforme_igual_ao_do_funcionario
    errors.add(:uniforme, 'deve ser do mesmo sexo e o Funcionário') unless funcionario.sexo == uniforme.sexo if funcionario && uniforme
  end
end
