class LeilaoObservacao < ApplicationRecord
  audited
  trimmed_fields :descricao

  belongs_to :leilao
  belongs_to :user

  validates :descricao, presence: true
  validates :user, presence: true
  validates :leilao, presence: true
end
