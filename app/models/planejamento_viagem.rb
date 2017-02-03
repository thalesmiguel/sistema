class PlanejamentoViagem < ApplicationRecord
  audited

  belongs_to :planejamento_escala
  belongs_to :planejamento_veiculo

  validates :planejamento_escala, presence: true
  validates :planejamento_veiculo, presence: true
end
