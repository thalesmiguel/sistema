class Uniforme < ApplicationRecord
  audited
  trimmed_fields :nome

  has_many :planejamento_escalas
  
  validates :nome, presence: true

  enum sexo: { masculino: 0, feminino: 1 }
end
