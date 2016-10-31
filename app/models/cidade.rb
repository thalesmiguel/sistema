class Cidade < ApplicationRecord
  belongs_to :estado
  has_many :enderecos
  has_many :fazendas

  validates :nome, presence: true, uniqueness: { scope: :estado_id, message: 'já cadastrada' }
end
