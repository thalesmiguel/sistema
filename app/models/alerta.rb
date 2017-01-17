class Alerta < ApplicationRecord
  audited
  trimmed_fields :descricao

  belongs_to :cliente
  belongs_to :user

  has_many :alerta_comentarios, dependent: :destroy

  validates :descricao, presence: true
  validates :cliente, presence: true
  validates :user, presence: true

  enum tipo: [ :alteração_de_cadastro, :faturamento, :incluído_no_jurídico, :observação, :pendência_de_documentos, :serasa_incluído, :serasa_nada_consta, :serasa_pendências ]
end
