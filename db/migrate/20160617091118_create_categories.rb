class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|

      t.string :name

      t.timestamps null: false
    end
    add_column :messages, :category_id, :integer
    add_index :messages, :category_id
  end
end
