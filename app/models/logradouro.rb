class Logradouro < ApplicationRecord
  audited
  trimmed_fields :nome, :cep, :complemento

  belongs_to :bairro

  validates :nome, presence: true
  validates :bairro, presence: true

end
