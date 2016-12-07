class Referencia < ApplicationRecord
  audited

  belongs_to :cliente

  validates :cliente, presence: true
  validates :nome, presence: true
end
