class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :nickname,   limit: 20
      t.string :first_name, null: false
      t.string :last_name,  null: false
      t.date :date_of_birth
      t.string :sex

      t.timestamps
    end
  end
end
