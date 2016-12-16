class Banco < ApplicationRecord
  audited
  trimmed_fields :nome

  has_many :cliente_bancos

  validates :nome, presence: true
  validates :codigo, uniqueness: true

end
