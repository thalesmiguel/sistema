class TaxaManual < ApplicationRecord
  audited
  trimmed_fields :nome

  belongs_to :leilao

  validates :leilao, presence: true

  enum tipo: { comprador: 0, vendedor: 1 }
end
