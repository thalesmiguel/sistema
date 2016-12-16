class Estado < ApplicationRecord
  audited
  trimmed_fields :nome, :sigla
  
  has_many :cidades

  validates :nome, presence: true, uniqueness: true
  validates :sigla, presence: true, uniqueness: true
  validate :sigla_deve_ter_dois_caracteres


  private

  def sigla_deve_ter_dois_caracteres
    sigla.length != 2 ? errors.add(:sigla, 'deve ter 2 caracteres') : true
  end
end
