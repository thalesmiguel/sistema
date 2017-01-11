class ClienteBanco < ApplicationRecord
  audited
  trimmed_fields :agencia, :conta_corrente, :obsevacao, :correntista_nome, :correntista_cpf_cnpj

  belongs_to :banco
  belongs_to :cidade
  belongs_to :cliente

  validates :banco, presence: true
  validates :cidade, presence: true
  validates :cliente, presence: true
  validate :pelo_menos_um_deve_estar_ativo
  validate :pelo_menos_um_deve_ser_primario

  def estado
    cidade.nil? ? 0 : cidade.estado_id
  end

  def banco_codigo
    banco.nil? ? "" : banco.codigo
  end

  def banco_nome
    banco.nil? ? "" : banco.nome
  end

end
