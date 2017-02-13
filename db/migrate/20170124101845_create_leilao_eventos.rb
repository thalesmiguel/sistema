class CreateLeilaoEventos < ActiveRecord::Migration[5.0]
  def change
    create_table :leilao_eventos do |t|
      t.string :nome
      t.datetime :data_inicio
      t.datetime :data_fim

      t.timestamps
    end
  end
end
