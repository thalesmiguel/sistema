class Patrocinador < ApplicationRecord
  audited
  trimmed_fields :nome

  has_attached_file :logo, :styles => { :thumb => ["140x140>", :jpg] }
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/, size: { less_than: 3.megabytes }

  has_many :leilao_patrocinadores
  has_many :patrocinador_leiloes, through: :leilao_patrocinadores, source: :leilao

  validates :nome, presence: true
end
