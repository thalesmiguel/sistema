require 'trimmer'

class ApplicationRecord < ActiveRecord::Base
  include Trimmer
  self.abstract_class = true


  def self.ativo
    where(ativo: true)
  end

  private
  # Validações
  def pelo_menos_um_deve_estar_ativo
    existentes = self.class.where(cliente_id: cliente_id).where.not(id: id)
    if (existentes.exists? && !existentes.exists?(ativo: true)) || (!existentes.exists? && (ativo == false || ativo.nil?))
      errors.add(:ativo, 'pelo menos 1 deve estar ativo')
    end
  end

  def pelo_menos_um_deve_ser_primario
    existentes = self.class.where(cliente_id: cliente_id).where.not(id: id)
    if (existentes.exists? && existentes.exists?(primario: true) && primario == true)
      errors.add(:primario, 'somente 1 deve ser primário')
    elsif (!existentes.exists? && primario == false)
      errors.add(:primario, '1 deve ser primário')
    end
  end

end
