class LeilaoEvento < ApplicationRecord
  audited
  trimmed_fields :nome

  belongs_to :leilao

  validates :nome, presence: true
  validates :leilao, presence: true
end
