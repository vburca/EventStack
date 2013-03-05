class CreateEventInterest < ActiveRecord::Migration
  def change
    create_table :events_interests, id: false do |t|
      t.integer :event_id,    null: false
      t.integer :interest_id, null: false
    end

    add_index :events_interests, [:event_id, :interest_id]
    add_index :events_interests, [:interest_id]
  end

end
