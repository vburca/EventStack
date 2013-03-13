class CreateEventMajor < ActiveRecord::Migration
  def change
    create_table :events_majors, id: false do |t|
      t.references :event,  null: false
      t.references :major,  null: false
    end

    add_index :events_majors, [:event_id, :major_id]
    add_index :events_majors, :major_id
  end
  
end
