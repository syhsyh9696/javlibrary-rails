class CreateNews < ActiveRecord::Migration[5.0]
  def change
    create_table :news do |t|
      t.string :title
      t.text :content
      t.string :publisher

      t.timestamps
    end
  end
end
