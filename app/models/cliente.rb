class Cliente < ApplicationRecord
  has_many :enderecos
  has_many :telefones
  has_many :emails
  has_many :fazendas
  has_many :cliente_bancos
  has_many :referencias
  has_many :lancar_autorizados

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

  def self.busca_por_associacao(tabela, campo, string)
    includes(tabela).where("#{tabela}.#{campo} LIKE ?", "#{string}%").order("#{tabela}.#{campo}").references(:fazendas)
    # joins(tabela.to_sym).where("#{tabela}.#{campo} LIKE ?", "#{string}%").order("#{tabela}.#{campo}")
  end
end
