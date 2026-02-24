class CreateGoods < ActiveRecord::Migration[7.0]
  def change
    create_table :goods do |t|
      t.string :ean
      t.string :nombre, null: false
      t.references :good_type, null: false, foreign_key: true
      t.integer :unidades
      t.text :notas
      t.boolean :cedido, null: false, default: false
      t.timestamps
    end
  end
end
