class Telefone < ApplicationRecord
  audited
  trimmed_fields :ddi, :ddd, :numero, :ramal, :nome_contato

  belongs_to :cliente

  validates :cliente, presence: true
  validates :ddi, presence: true
  validates :ddd, presence: true
  validates :numero, presence: true

  validate :pelo_menos_um_deve_estar_ativo

  enum tipo: [ :canal, :celular, :comercial, :fax, :fax_fazenda, :fazenda, :financeiro, :residencial, :torpedo ]

end
