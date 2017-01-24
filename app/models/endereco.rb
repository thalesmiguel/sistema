class Endereco < ApplicationRecord
  audited
  trimmed_fields :logradouro, :numero, :complemento, :caixa_postal, :bairro, :pais, :cep, :aos_cuidados

  belongs_to :cliente
  belongs_to :cidade

  validates :cliente, presence: true
  validates :cidade, presence: true
  validates :logradouro, presence: true
  validate :pelo_menos_um_deve_estar_ativo
  validate :pelo_menos_um_deve_ser_primario

  enum tipo: { correspondência: 0, faturamento: 1 }

  def estado
    cidade.nil? ? 0 : cidade.estado_id
  end

  def self.primario
    where(primario: true).first
  end

end
