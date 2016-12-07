class ClienteBanco < ApplicationRecord
  audited

  belongs_to :banco
  belongs_to :cidade
  belongs_to :cliente

  validates :banco, presence: true
  validates :cidade, presence: true
  validates :cliente, presence: true
  validate :pelo_menos_um_deve_estar_ativo
  validate :pelo_menos_um_deve_ser_primario

end
