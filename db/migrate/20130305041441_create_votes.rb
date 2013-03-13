class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes, id: false do |t|
      t.references :voter,  null: false           # the voter user
      t.references :voted_event,   null: false    # the voted event
    end

    add_index :votes, [:voter_id, :voted_event_id]
    add_index :votes, :voted_event_id
  end

end
