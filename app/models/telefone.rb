class Telefone < ApplicationRecord
  audited
  trimmed_fields :ddi, :ddd, :numero, :ramal, :nome_contato

  belongs_to :cliente

  validates :cliente, presence: true
  validates :ddi, presence: true
  validates :ddd, presence: true
  validates :numero, presence: true

  validate :pelo_menos_um_deve_estar_ativo

  enum tipo: { canal: 0, celular: 1, comercial: 2, fax: 3, fax_fazenda: 4, fazenda: 5, financeiro: 6, residencial: 7, torpedo: 8 }

end
