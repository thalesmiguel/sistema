class Fazenda < ApplicationRecord
  audited
  trimmed_fields :nome, :cep, :endereco, :area, :observacao, :inscricao_estadual, :cnpj_fazenda, :incra, :cnpj_produto

  belongs_to :cliente
  belongs_to :cidade

  validates :nome, presence: true
  validates :cliente, presence: true
  validates :cidade, presence: true
  validate :pelo_menos_um_deve_estar_ativo

  enum tipo: { arrendada: 0, não_informado: 1, própria: 2 }

  def estado
    cidade.nil? ? 0 : cidade.estado_id
  end
end
