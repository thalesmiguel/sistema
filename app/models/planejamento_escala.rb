class PlanejamentoEscala < ApplicationRecord
  belongs_to :funcao
  belongs_to :uniforme
  belongs_to :leilao
  belongs_to :funcionario, class_name: 'Cliente'

  monetize :diaria_valor_centavos
  monetize :despesa_valor_centavos
end
