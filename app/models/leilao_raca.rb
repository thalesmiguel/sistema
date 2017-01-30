class LeilaoRaca < ApplicationRecord
  audited

  belongs_to :leilao
  belongs_to :raca

  validates :leilao, presence: true
  validates :raca, presence: true
end
