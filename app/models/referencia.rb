class Referencia < ApplicationRecord
  audited
  trimmed_fields :nome, :telefone, :observacao

  belongs_to :cliente

  validates :cliente, presence: true
  validates :nome, presence: true
end
