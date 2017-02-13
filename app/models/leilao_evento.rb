class LeilaoEvento < ApplicationRecord
  audited
  trimmed_fields :nome

  has_many :leiloes

  validates :nome, presence: true
end
