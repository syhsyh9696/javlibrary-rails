class CreateActors < ActiveRecord::Migration[5.0]
  def change
    create_table :actors do |t|
      t.string :name
      t.string :actor_label
      t.string :type
      t.timestamps
    end
  end
end
