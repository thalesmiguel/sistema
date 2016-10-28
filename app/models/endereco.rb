class Endereco < ApplicationRecord
  belongs_to :cliente
  belongs_to :cidade

  validates :logradouro, presence: true
  validate :pelo_menos_um_endereco_deve_estar_ativo

  enum tipo: [:correspondência, :faturamento]


  private

  def pelo_menos_um_endereco_deve_estar_ativo
    enderecos_existentes = Endereco.where(cliente_id: cliente_id)

    if enderecos_existentes.exists? && !enderecos_existentes.exists?(ativo: true)
      errors.add(:ativo, 'pelo menos 1 endereço deve estar ativo')
    end

    # if Endereco.exists?(cliente_id: cliente_id) && !Endereco.exists?(cliente_id: cliente_id, ativo: true)
    #   errors.add(:ativo, 'pelo menos 1 endereço deve estar ativo')
    # end
  end

end
