class CreatePlanejamentoViagens < ActiveRecord::Migration[5.0]
  def change
    create_table :planejamento_viagens do |t|
      t.references :planejamento_escala, foreign_key: true
      t.references :planejamento_veiculo, foreign_key: true
      t.boolean :ida
      t.boolean :volta

      t.timestamps
    end
  end
end
