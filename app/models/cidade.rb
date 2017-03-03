class Cidade < ApplicationRecord
  audited
  trimmed_fields :nome

  belongs_to :estado
  has_many :enderecos
  has_many :fazendas
  has_many :cliente_bancos
  has_many :empresas
  has_many :leiloes
  has_many :leiloeiros

  validates :nome, presence: true, uniqueness: { scope: :estado_id, message: 'já cadastrada' }

  def estado_sigla
    estado.sigla
  end
end
