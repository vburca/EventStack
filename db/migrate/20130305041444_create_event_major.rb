class CreateEventMajor < ActiveRecord::Migration
  def change
    create_table :events_majors, id: false do |t|
      t.integer :event_id,  null: false
      t.integer :major_id,  null: false
    end

    add_index :events_majors, [:event_id, :major_id]
    add_index :events_majors, [:major_id]
  end
  
end
