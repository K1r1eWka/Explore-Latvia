class CreateEdges < ActiveRecord::Migration[8.1]
  def change
    create_table :edges do |t|
      t.references :from_node, null: false, foreign_key: { to_table: :nodes }
      t.references :to_node, null: false, foreign_key: { to_table: :nodes }
      t.decimal :distance, precision: 10, scale: 2, null: false

      t.timestamps
    end

    add_index :edges, [:from_node_id, :to_node_id], unique: true
  end
end
