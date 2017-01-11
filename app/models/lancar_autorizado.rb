class LancarAutorizado < ApplicationRecord
  audited
  trimmed_fields :nome, :cnpj, :observacao

  has_attached_file :procuracao, :styles => { :thumb => ["140x140>", :jpg] }
  validates_attachment_content_type :procuracao, content_type: "application/pdf", size: { less_than: 3.megabytes }

  belongs_to :cliente

  validates :cliente, presence: true
  validates :nome, presence: true
end
