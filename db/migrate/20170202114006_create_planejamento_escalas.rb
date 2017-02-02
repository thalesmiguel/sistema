class CreatePlanejamentoEscalas < ActiveRecord::Migration[5.0]
  def change
    create_table :planejamento_escalas do |t|
      t.integer :funcionario_id
      t.references :funcao, foreign_key: true
      t.references :uniforme, foreign_key: true
      t.monetize :diaria_valor
      t.string :diaria_descricao
      t.monetize :despesa_valor
      t.string :despesa_descricao
      t.string :avaliacao
      t.string :avaliacao_observacao
      t.references :leilao

      t.timestamps
    end
  end
end
