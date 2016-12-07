class Banco < ApplicationRecord
  audited

  has_many :cliente_bancos

  validates :nome, presence: true
  validates :codigo, uniqueness: true

end
