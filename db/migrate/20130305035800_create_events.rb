class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name,             limit: 20, null: false
      t.string :description,      limit: 800, null: false
      t.datetime :start_datetime, null: false
      t.datetime :end_datetime,   null: false
      t.string :location,         null: false
      t.boolean :food_provided
      t.references :creator

      t.timestamps
    end
    add_index :events, :user_id
  end
end
