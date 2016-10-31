class Email < ApplicationRecord
  belongs_to :cliente

  validates :email, presence: true
  validate :pelo_menos_um_deve_estar_ativo

  validates :cliente, presence: true
end
