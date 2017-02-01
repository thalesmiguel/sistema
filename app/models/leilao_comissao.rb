class LeilaoComissao < ApplicationRecord
  audited
  trimmed_fields :financ_comissao_compra, :financ_comissao_venda, :financ_solicitacao_entrada

  belongs_to :leilao
  belongs_to :promotor_banco, class_name: "ClienteBanco", foreign_key: :promotor_banco_id

  validates :leilao, presence: true

  monetize :valor_fixo_venda_centavos

  enum tipo: { rateio_de_despesas: 0, comissão_de_venda: 1 }
end
