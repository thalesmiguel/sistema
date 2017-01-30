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

  has_many :leilao_observacoes
  has_one :leilao_evento

  belongs_to :leilao_anterior, class_name: "Leilao"
  has_many :leilao_posterior, class_name: "Leilao", foreign_key: :leilao_anterior_id

  has_many :leilao_promotores
  has_many :promotores, through: :leilao_promotores, source: :cliente


  enum categoria: { elite: 0, corte: 1, outro: 2, shopping: 3 }
  enum modalidade: { recinto: 0, virtual: 1, virtual_com_ponto_de_apoio: 2 }
  enum tipo: { leilão_normal: 0, sub_leilão: 1, leilão_internet: 2, shopping_internet: 3, leilão_webcasting: 4, leilão_com_pré_lance: 5, leilão_doação: 6 }
  enum situacao: { aguardando_confirmação: 0, leberado_planejamento: 1, leberado_empresa: 2, realizado: 3, cancelado: 4 }
end
