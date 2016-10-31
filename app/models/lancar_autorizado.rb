class LancarAutorizado < ApplicationRecord
  belongs_to :cliente

  validates :cliente, presence: true
  validates :nome, presence: true
end
