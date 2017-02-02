class Funcao < ApplicationRecord
  audited
  trimmed_fields :nome

  has_many :planejamento_escalas

  validates :nome, presence: true
end
