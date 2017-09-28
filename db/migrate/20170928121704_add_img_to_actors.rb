class AddImgToActors < ActiveRecord::Migration[5.0]
  def change
    add_column :actors, :img, :string
  end
end
