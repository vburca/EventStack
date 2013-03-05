class CreateEventUser < ActiveRecord::Migration
  def change
    # create_table :voted_events_voters, id: false do |t|
    # Can I even do that?? With so many '_', will it recognize what I want???
    # Is this entire voted_events & voters business even possible??

    create_table :events_users, id: false do |t|
      # for voted_event?
      # t.integer :voted_event_id,  null: false
      t.integer :event_id,  null: false
      # for voters?
      # t.integer :voter_id,  null: false
      t.integer :user_id,   null: false
    end

    # with :voted_event_id and :voter_id
    add_index :events_users, [:event_id, :user_id]
    add_index :events_users, [:user_id]
  end

end
