class AlertaComentario < ApplicationRecord
  audited
  trimmed_fields :descricao
  
  belongs_to :alerta

  validates :descricao, presence: true

  validates :alerta, presence: true
end
