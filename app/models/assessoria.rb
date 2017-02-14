class Assessoria < ApplicationRecord
  audited
  trimmed_fields :nome, :observacao

  has_attached_file :logo, :styles => { :thumb => ["140x140>", :jpg] }
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/, size: { less_than: 3.megabytes }

  has_many :leilao_assessorias
  has_many :assessoria_leiloes, through: :leilao_assessorias, source: :leilao

  validates :nome, presence: true
end
