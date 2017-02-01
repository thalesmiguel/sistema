class CreateLeilaoPadroes < ActiveRecord::Migration[5.0]
  def change
    create_table :leilao_padroes do |t|
      t.integer :pagamento_elite_id
      t.integer :pagamento_corte_id
      t.integer :pagamento_outros_id
      t.money   :dolar
      t.money   :arroba
      t.references :leilao, foreign_key: true

      t.timestamps
    end
    # add_foreign_key :leilao_padroes, :pagamento_condicao, column: :pagamento_elite_id, primary_key: :id
    # add_foreign_key :leilao_padroes, :pagamento_condicao, column: :pagamento_corte_id, primary_key: :id
    # add_foreign_key :leilao_padroes, :pagamento_condicao, column: :pagamento_outros_id, primary_key: :id
  end
end
