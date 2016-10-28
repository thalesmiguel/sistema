class Cliente < ApplicationRecord
  has_many :enderecos

  validates :nome, presence: true
  validates :cpf_cnpj, uniqueness: true
  validates :cadastro_tipo, presence: true
  validates :marketing_tipos, presence: true
  validates :pessoa_tipo, presence: true

  serialize :marketing_tipos, Array

  enum sexo: [ :masculino, :feminino ]
  enum pessoa_tipo: [ :física, :jurídica, :outra ]
  enum cadastro_tipo: [ :cliente, :fornecedor, :funcionário, :prestador_de_serviço, :visitante ]


  def self.busca_por_campo(campo, string)
    where("#{campo} LIKE ?", "#{string}%").order("#{campo}")
  end
end
