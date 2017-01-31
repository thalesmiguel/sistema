class CreatePagamentoParcelas < ActiveRecord::Migration[5.0]
  def change
    create_table :pagamento_parcelas do |t|
      t.integer :parcela
      t.integer :captacoes
      t.date :vencimento
      t.references :pagamento_condicao, foreign_key: true

      t.timestamps
    end
  end
end
