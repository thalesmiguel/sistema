class LeilaoCanal < ApplicationRecord
  audited

  belongs_to :leilao
  belongs_to :canal

  validates :leilao, presence: true
  validates :canal, presence: true
end
