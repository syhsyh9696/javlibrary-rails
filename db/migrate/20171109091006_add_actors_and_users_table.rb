class AddActorsAndUsersTable < ActiveRecord::Migration[5.0]
  def change
    create_table :actors_users do |t|
      t.belongs_to :actor, index: true
      t.belongs_to :user, index: true

      t.timestamps
    end

    add_index :actors_users, [:actor_id, :user_id], unique: true
  end
end
