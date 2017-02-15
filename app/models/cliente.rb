class Cliente < ApplicationRecord
  audited
  trimmed_fields :nome, :apelido, :ficticio, :sexo, :data_nascimento, :inscricao_estadual, :cpf_cnpj, :rg, :rg_emissor, :rg_data_emissao, :pessoa_tipo, :cadastro_tipo, :obsevacao

  has_many :enderecos, dependent: :destroy
  has_many :telefones, dependent: :destroy
  has_many :emails, dependent: :destroy
  has_many :fazendas, dependent: :destroy
  has_many :cliente_bancos, dependent: :destroy
  has_many :referencias, dependent: :destroy
  has_many :lancar_autorizados, dependent: :destroy
  has_many :tags, dependent: :destroy
  has_many :empresas, dependent: :destroy
  has_many :alertas, dependent: :destroy

  has_many :planejamento_escalas, foreign_key: 'funcionario_id', dependent: :destroy

  has_many :leilao_promotores, dependent: :destroy
  has_many :promotor_leiloes, through: :leilao_promotores, source: :leilao
  has_many :leilao_convidados, dependent: :destroy
  has_many :convidado_leiloes, through: :leilao_convidados, source: :leilao

  validates :nome, presence: true
  validates :cpf_cnpj, uniqueness: true
  validates :cadastro_tipo, presence: true
  validates :marketing_tipos, presence: true
  validates :pessoa_tipo, presence: true

  serialize :marketing_tipos, Array

  enum sexo: { masculino: 0, feminino: 1 }
  enum pessoa_tipo: { física: 0, jurídica: 1, outra: 2 }
  enum cadastro_tipo: { cliente: 0, fornecedor: 1, funcionário: 2, prestador_de_serviço: 3, visitante: 4 }


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
    alertas.serasa_incluído.ativo.count + alertas.serasa_pendências.ativo.count
  end

  def informacoes_adicionais
    informacoes_adicionais = []
    informacoes_adicionais << "ativo" if ativo
    informacoes_adicionais << "serasa" if pendencias_no_serasa > 0

    return informacoes_adicionais
  end

end
