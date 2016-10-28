class Cidade < ApplicationRecord
  belongs_to :estado
  
  validates :nome, presence: true, uniqueness: { scope: :estado_id, message: 'já cadastrada' }
end
