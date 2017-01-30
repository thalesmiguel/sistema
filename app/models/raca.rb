class Raca < ApplicationRecord
  audited
  trimmed_fields :codigo, :nome

  validates :codigo, presence: true
  validates :nome, presence: true

  enum especio: { asinino: 0, ave: 1, bovino: 2, canino: 3, caprino: 4, equino: 5, felino: 6, muar: 7, outro: 8, ovino: 9, suino: 10, veículo: 11 }

end
