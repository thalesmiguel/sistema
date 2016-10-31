class Endereco < ApplicationRecord
  belongs_to :cliente
  belongs_to :cidade

  validates :cliente, presence: true
  validates :cidade, presence: true
  validates :logradouro, presence: true
  validate :pelo_menos_um_deve_estar_ativo
  validate :pelo_menos_um_deve_ser_primario

  enum tipo: [:correspondência, :faturamento]

end
