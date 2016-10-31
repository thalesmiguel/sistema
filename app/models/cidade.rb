class Cidade < ApplicationRecord

  belongs_to :estado
  has_many :enderecos
  has_many :fazendas
  has_many :cliente_bancos

  validates :nome, presence: true, uniqueness: { scope: :estado_id, message: 'já cadastrada' }
end
