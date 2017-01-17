class Cliente < ApplicationRecord
  audited
  trimmed_fields :nome, :apelido, :ficticio, :sexo, :data_nascimento, :inscricao_estadual, :cpf_cnpj, :rg, :rg_emissor, :rg_data_emissao, :pessoa_tipo, :cadastro_tipo, :obsevacao

  has_many :enderecos
  has_many :telefones
  has_many :emails
  has_many :fazendas
  has_many :cliente_bancos
  has_many :referencias
  has_many :lancar_autorizados
  has_many :tags
  has_many :empresas
  has_many :alertas

  validates :nome, presence: true
  validates :cpf_cnpj, uniqueness: true
  validates :cadastro_tipo, presence: true
  validates :marketing_tipos, presence: true
  validates :pessoa_tipo, presence: true

  serialize :marketing_tipos, Array

  enum sexo: [ :masculino, :feminino ]
  enum pessoa_tipo: [ :física, :jurídica, :outra ]
  enum cadastro_tipo: [ :cliente, :fornecedor, :funcionário, :prestador_de_serviço, :visitante ]


  def estado_primario(campo = "")
    if campo == "sigla"
      enderecos.exists? ? enderecos.primario.cidade.estado.sigla : ""
    else
      enderecos.exists? ? enderecos.primario.cidade.estado : ""
    end
  end

  def cidade_primaria(campo = "")
    if campo == "nome"
      enderecos.exists? ? enderecos.primario.cidade.nome : ""
    else
      enderecos.exists? ? enderecos.primario.cidade : ""
    end
  end

  def self.busca_por_campo(campo, string)
    where("#{campo} LIKE ?", "#{string}%").order("#{campo}")
  end

  def self.busca_por_associacao(tabela, campo, string)
    includes(tabela).where("#{tabela}.#{campo} LIKE ?", "#{string}%").order("#{tabela}.#{campo}").references(:fazendas)
    # joins(tabela.to_sym).where("#{tabela}.#{campo} LIKE ?", "#{string}%").order("#{tabela}.#{campo}")
  end

  def self.marketing_tipos_array
    ["E-mail", "Fax", "Mala_Direta", "SMS", "Telefone"]
  end

  def pendencias_no_serasa
    alertas.serasa_incluído.count + alertas.serasa_pendências.count
  end
end
