class Empresa < ApplicationRecord
  audited

  belongs_to :cidade, optional: true
  belongs_to :cliente

  validates :cliente, presence: true
  validates :nome, presence: true
end
