class Alerta < ApplicationRecord
  belongs_to :cliente

  validates :descricao, presence: true
  validates :cliente, presence: true

  enum tipo: [ :alteração_cadastro, :faturamento, :juridico_incluído, :pendência_de_documentos, :serasa_incluído, :serasa_nada_consta, :serasa_pendências, :observação ]
end
