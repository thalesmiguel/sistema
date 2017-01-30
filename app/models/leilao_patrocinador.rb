class LeilaoPatrocinador < ApplicationRecord
  audited

  belongs_to :leilao
  belongs_to :patrocinador

  validates :leilao, presence: true
  validates :patrocinador, presence: true
end
