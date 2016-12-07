class Fazenda < ApplicationRecord
  audited

  belongs_to :cliente
  belongs_to :cidade

  validates :nome, presence: true
  validates :cliente, presence: true
  validates :cidade, presence: true
  validate :pelo_menos_um_deve_estar_ativo

  enum tipo: [ :arrendada, :não_informado, :própria ]
end
