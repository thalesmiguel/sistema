class Subtipo < ApplicationRecord
  audited
  trimmed_fields :codigo, :nome


  has_many :leiloes, class_name: "Leilao", foreign_key: :subtipo_lotes_id

  validates_presence_of :codigo
  validates_presence_of :nome
end
