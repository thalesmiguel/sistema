class Tag < ApplicationRecord
  audited
  trimmed_fields :nome

  belongs_to :cliente

  validates :codigo, presence: true
  validates :nome, presence: true
  validates :cliente, presence: true
end
