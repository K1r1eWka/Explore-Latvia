class CreatePlaces < ActiveRecord::Migration[8.1]
  def change
    create_table :places do |t|
      t.string :name, null: false
      t.text :description
      t.string :category
      t.references :node, null: false, foreign_key: true
      t.timestamps
    end
  end
end
