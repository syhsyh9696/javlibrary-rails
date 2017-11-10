class AddIndexActorsUsersTable < ActiveRecord::Migration[5.0]
  def change
    add_index :actors_users, [:actor_id, :user_id], unique: true
  end
end
