class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :message_id

      t.timestamps null: false
    end
    add_index :comments, :message_id
  end
end
