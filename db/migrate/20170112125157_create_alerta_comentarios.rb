class CreateAlertaComentarios < ActiveRecord::Migration[5.0]
  def change
    create_table :alerta_comentarios do |t|
      t.text :descricao
      t.references :alerta, foreign_key: true

      t.timestamps
    end
  end
end
