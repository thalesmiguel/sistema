class Leiloeiro < ApplicationRecord
  audited
  trimmed_fields :nome_contrato, :razao_social, :cpf, :cnpj, :sindicato, :endereco, :cep, :email, :telefone, :fax, :sigla

  belongs_to :cidade
  belongs_to :cliente

  has_many :leilao_leiloeiros, dependent: :destroy
  has_many :leiloes, through: :leilao_leiloeiros

  has_attached_file :foto, :styles => { :thumb => ["140x140>", :jpg] }
  validates_attachment_content_type :foto, content_type: /\Aimage\/.*\z/, size: { less_than: 3.megabytes }

  validates :razao_social, presence: true
  validates :sigla, length: { is: 2 }, allow_blank: true
end
