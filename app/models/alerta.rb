class Alerta < ApplicationRecord
  audited
  trimmed_fields :descricao

  belongs_to :cliente
  belongs_to :user

  has_many :alerta_comentarios, dependent: :destroy

  validates :descricao, presence: true
  validates :cliente, presence: true
  validates :user, presence: true

  enum tipo: { alteração_de_cadastro: 0, faturamento: 1, incluído_no_jurídico: 2, observação: 3,
               pendência_de_documentos: 4, serasa_incluído: 5, serasa_nada_consta: 6, serasa_pendências: 7 }
end
