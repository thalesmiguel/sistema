class LeilaoPadrao < ApplicationRecord
  audited
  belongs_to :leilao
  belongs_to :pagamento_elite, class_name: "PagamentoCondicao"
  belongs_to :pagamento_corte, class_name: "PagamentoCondicao"
  belongs_to :pagamento_outros, class_name: "PagamentoCondicao"

  monetize :dolar_centavos
  monetize :arroba_centavos

  validates :leilao, presence: true
end
