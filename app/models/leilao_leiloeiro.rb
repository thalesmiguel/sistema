class LeilaoLeiloeiro < ApplicationRecord
  audited

  belongs_to :leilao
  belongs_to :leiloeiro

  validates :leilao, presence: true
  validates :leiloeiro, presence: true
end
