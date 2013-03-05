class CreateInterests < ActiveRecord::Migration
  def change
    create_table :interests do |t|
      t.string :name,   limit: 50, null: false

      t.timestamps
    end
  end
end
