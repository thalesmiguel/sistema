class CreateBandeiras < ActiveRecord::Migration[5.0]
  def change
    create_table :bandeiras do |t|
      t.string :nome
      t.string :sigla
      t.string :cor
      t.attachment :logo

      t.timestamps
    end
  end
end
