class Leilao < ApplicationRecord
  audited
  trimmed_fields :nome, :data_inicio, :data_fim, :nome_agenda, :nome_site

  has_attached_file :logo, :styles => { :thumb => ["140x140>", :jpg] }
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/, size: { less_than: 3.megabytes }

  validates :nome, presence: true

  belongs_to :cidade
  belongs_to :testemunha_1, class_name: "User"
  belongs_to :testemunha_2, class_name: "User"
  belongs_to :subtipo_lotes, class_name: "Subtipo"
  belongs_to :leilao_evento

  has_many :leilao_observacoes, dependent: :destroy
  has_many :taxa_manuais, dependent: :destroy
  has_many :taxa_automaticas, dependent: :destroy
  has_many :planejamento_escalas, dependent: :destroy
  has_many :planejamento_veiculos, dependent: :destroy
  has_one :leilao_padrao, dependent: :destroy
  has_one :leilao_comissao, dependent: :destroy

  belongs_to :leilao_anterior, class_name: "Leilao"
  has_many :leilao_posterior, class_name: "Leilao", foreign_key: :leilao_anterior_id

  has_many :leilao_promotores, dependent: :destroy
  has_many :promotores, through: :leilao_promotores, source: :cliente
  has_many :leilao_convidados, dependent: :destroy
  has_many :convidados, through: :leilao_convidados, source: :cliente
  has_many :leilao_bandeiras, dependent: :destroy
  has_many :bandeiras, through: :leilao_bandeiras
  has_many :leilao_canais, dependent: :destroy
  has_many :canais, through: :leilao_canais
  has_many :leilao_racas, dependent: :destroy
  has_many :racas, through: :leilao_racas
  has_many :leilao_patrocinadores, dependent: :destroy
  has_many :patrocinadores, through: :leilao_patrocinadores
  has_many :leilao_assessorias, dependent: :destroy
  has_many :assessorias, through: :leilao_assessorias
  has_many :leilao_leiloeiros, dependent: :destroy
  has_many :leiloeiros, through: :leilao_leiloeiros


  enum categoria: { elite: 0, corte: 1, outro: 2, shopping: 3 }
  enum modalidade: { recinto: 0, virtual: 1, virtual_com_ponto_de_apoio: 2 }
  enum tipo: { leilão_normal: 0, sub_leilão: 1, leilão_internet: 2, shopping_internet: 3, leilão_webcasting: 4, leilão_com_pré_lance: 5, leilão_doação: 6 }
  enum situacao: { aguardando_confirmação: 0, liberado_planejamento: 1, liberado_empresa: 2, realizado: 3, cancelado: 4 }


  def estado
    cidade.nil? ? 0 : cidade.estado_id
  end

  def local
    # TODO: Adicionar o endereço do recinto
    cidade.nome + "/" + cidade.estado_sigla if cidade
  end

  def data_inicio
    super.strftime "%d/%m/%Y %H:%M" unless super.nil?
  end

  def data_fim
    super.strftime "%d/%m/%Y %H:%M" unless super.nil?
  end

  def nome_agenda
    (super == "" || super.nil?) ? nome : super
  end

  def nome_site
    (super == "" || super.nil?) ? nome : super
  end

  def evento_nome
    leilao_evento.nil? ? "" : leilao_evento.nome
  end

  def leilao_anterior_nome
    leilao_anterior.nil? ? "" : leilao_anterior.nome
  end

  def subtipo_lotes_nome
    subtipo_lotes.nil? ? "" : subtipo_lotes.nome
  end

end
