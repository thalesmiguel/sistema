class LeilaoAssessoria < ApplicationRecord
  audited

  belongs_to :leilao
  belongs_to :assessoria

  validates :leilao, presence: true
  validates :assessoria, presence: true
end
