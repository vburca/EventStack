class CreateMajorUser < ActiveRecord::Migration
  def change
    create_table :majors_users, id: false do |t|
      t.integer :major_id,  null: false
      t.integer :user_id,   null: false
    end

    add_index :majors_users, [:major_id, :user_id]
    add_index :majors_users, [:user_id]
  end

end
