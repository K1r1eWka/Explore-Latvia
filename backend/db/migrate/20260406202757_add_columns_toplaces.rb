class AddColumnsToplaces < ActiveRecord::Migration[8.1]
  def change
    add_column :places, :name, :string
    add_column :places, :description, :text
    add_column :places, :category, :string
    add_column :places, :node_id, :bigint
  end
end