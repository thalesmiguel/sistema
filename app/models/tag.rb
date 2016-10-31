class Tag < ApplicationRecord
  belongs_to :cliente

  validates :codigo, presence: true
  validates :nome, presence: true
  validates :cliente, presence: true
end
