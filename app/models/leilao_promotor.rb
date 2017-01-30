class LeilaoPromotor < ApplicationRecord
  audited

  belongs_to :leilao
  belongs_to :cliente

  validates :leilao, presence: true
  validates :cliente, presence: true
end
