class Endereco < ApplicationRecord
  belongs_to :cliente
  belongs_to :cidade

  validates :cliente, presence: true
  validates :cidade, presence: true

  validates :logradouro, presence: true
  validate :pelo_menos_um_endereco_deve_estar_ativo
  validate :um_endereco_deve_ser_primario

  enum tipo: [:correspondência, :faturamento]

  private

  def pelo_menos_um_endereco_deve_estar_ativo
    enderecos_existentes = Endereco.where(cliente_id: cliente_id).where.not(id: id)
    if (enderecos_existentes.exists? && !enderecos_existentes.exists?(ativo: true)) || (!enderecos_existentes.exists? && ativo == false)
      errors.add(:ativo, 'pelo menos 1 endereço deve estar ativo')
    end
  end

  def um_endereco_deve_ser_primario
    enderecos_existentes = Endereco.where(cliente_id: cliente_id).where.not(id: id)
    if (enderecos_existentes.exists? && enderecos_existentes.exists?(primario: true) && primario == true)
      errors.add(:primario, 'somente 1 endereço deve ser primário')
    elsif (!enderecos_existentes.exists? && primario == false)
      errors.add(:primario, '1 endereço deve ser primário')
    end
  end

end
