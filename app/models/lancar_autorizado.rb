class LancarAutorizado < ApplicationRecord
  audited

  has_attached_file :procuracao
  validates_attachment_content_type :procuracao, content_type: "application/pdf"

  belongs_to :cliente

  validates :cliente, presence: true
  validates :nome, presence: true
end
