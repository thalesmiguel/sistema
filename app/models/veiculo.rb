class Veiculo < ApplicationRecord
  audited
  trimmed_fields :modelo, :chassi, :placa, :renavam, :motor, :nf

  has_many :planejamento_veiculos

  validates :modelo, presence: true

  enum combustivel: { gasolina: 0, etanol: 1, diesel: 2, flex: 3 }
end
