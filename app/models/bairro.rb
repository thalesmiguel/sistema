class Bairro < ApplicationRecord
  audited
  trimmed_fields :nome

  belongs_to :cidade
  has_many :logradouros

  validates :nome, presence: true
  validates :cidade, presence: true
  validates :nome, presence: true, uniqueness: { scope: :cidade_id, message: 'já cadastrada' }

end
