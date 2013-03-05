class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content,    limit: 500, null: false
      t.references :user
      t.references :event

      t.timestamps
    end
    add_index :comments, :user_id
  end
end
