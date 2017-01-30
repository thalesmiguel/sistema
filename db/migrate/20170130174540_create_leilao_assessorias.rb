class CreateLeilaoAssessorias < ActiveRecord::Migration[5.0]
  def change
    create_table :leilao_assessorias do |t|
      t.references :leilao, foreign_key: true
      t.references :assessoria, foreign_key: true

      t.timestamps
    end
  end
end
