class CreateAssessorias < ActiveRecord::Migration[5.0]
  def change
    create_table :assessorias do |t|
      t.string :nome
      t.text :observacao
      t.attachment :logo

      t.timestamps
    end
  end
end
