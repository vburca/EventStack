class AddUsernameToUsers < ActiveRecord::Migration
  def up
    add_column :users, :username, :string, limit: 20
  end

  def down
    remove_column :users, :username
  end

end
