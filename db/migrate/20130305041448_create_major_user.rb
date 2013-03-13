class CreateMajorUser < ActiveRecord::Migration
  def change
    create_table :majors_users, id: false do |t|
      t.references :major,  null: false
      t.references :user,   null: false
    end

    add_index :majors_users, [:major_id, :user_id]
    add_index :majors_users, :user_id
  end

end
