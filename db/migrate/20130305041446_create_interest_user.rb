class CreateInterestUser < ActiveRecord::Migration
  def change
    create_table :interests_users, id: false do |t|
      t.integer :interest_id, null: false
      t.integer :user_id,     null: false
    end

    add_index :interests_users, [:interest_id, :user_id]
    add_index :interests_users, [:user_id]
  end

end
