class CreatePlanejamentoVeiculos < ActiveRecord::Migration[5.0]
  def change
    create_table :planejamento_veiculos do |t|
      t.datetime :data_inicio
      t.datetime :data_fim
      t.text :observacao
      t.references :leilao, foreign_key: true
      t.references :veiculo, foreign_key: true

      t.timestamps
    end
  end
end
