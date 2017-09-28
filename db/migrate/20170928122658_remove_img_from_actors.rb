class RemoveImgFromActors < ActiveRecord::Migration[5.0]
  def change
    remove_column :actors, :img
  end
end
