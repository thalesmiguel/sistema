class LeilaoEvento < ApplicationRecord
  audited
  trimmed_fields :descricao

  belongs_to :leilao

  validates :descricao, presence: true
  validates :leilao, presence: true
end
