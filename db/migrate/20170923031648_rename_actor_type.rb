class RenameActorType < ActiveRecord::Migration[5.0]
  def change
    rename_column :actors, :type, :actor_type
  end
end
