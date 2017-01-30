class Bandeira < ApplicationRecord
  audited
  trimmed_fields :nome, :sigla, :cor

  has_attached_file :logo, :styles => { :thumb => ["140x140>", :jpg] }
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/, size: { less_than: 3.megabytes }

  has_many :leilao_bandeiras
  has_many :bandeira_leiloes, through: :leilao_bandeiras, source: :leilao

  validates :nome, presence: true

end
