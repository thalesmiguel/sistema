class Empresa < ApplicationRecord
  audited
  trimmed_fields :nome, :cnpj, :cargo, :logradouro, :numero, :complemento, :bairro, :caixa_postal

  belongs_to :cidade, optional: true
  belongs_to :cliente

  validates :cliente, presence: true
  validates :nome, presence: true
end
