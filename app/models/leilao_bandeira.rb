class LeilaoBandeira < ApplicationRecord
  audited

  belongs_to :leilao
  belongs_to :bandeira

  validates :leilao, presence: true
  validates :bandeira, presence: true
end
