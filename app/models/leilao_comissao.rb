class LeilaoComissao < ApplicationRecord
  audited

  belongs_to :leilao

  validates :leilao, presence: true

  monetize :valor_fixo_venda_centavos

  enum tipo: { rateio_de_despesas: 0, comissão_de_venda: 1 }
end
