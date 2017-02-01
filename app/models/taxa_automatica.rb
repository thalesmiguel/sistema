class TaxaAutomatica < ApplicationRecord
  audited
  trimmed_fields :nome, :nome_resumido

  belongs_to :leilao

  validates :leilao, presence: true

  serialize :cobrado_de, Array
  monetize :valor_centavos
  enum tipo: { comprador: 0, vendedor: 1 }
  enum cobranca_por: { animais: 0, lotes: 1 }
  enum cobranca_lote_tipo: { corte: 0, elite: 1, outros: 2, todos: 3 }
end
