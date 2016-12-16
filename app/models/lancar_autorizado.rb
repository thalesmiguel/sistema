class LancarAutorizado < ApplicationRecord
  audited
  trimmed_fields :nome, :cnpj, :observacao

  has_attached_file :procuracao
  validates_attachment_content_type :procuracao, content_type: "application/pdf"

  belongs_to :cliente

  validates :cliente, presence: true
  validates :nome, presence: true
end
