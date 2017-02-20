class CreatePagamentoCondicoes < ActiveRecord::Migration[5.0]
  def change
    create_table :pagamento_condicoes do |t|
      t.string :nome
      t.integer :tipo
      t.integer :captacoes
      t.integer :parcelas
      t.integer :frequencia
      t.boolean :entrada, default: false

      t.timestamps
    end
  end
end
