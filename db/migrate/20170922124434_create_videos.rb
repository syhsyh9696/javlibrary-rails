class CreateVideos < ActiveRecord::Migration[5.0]
  def change
    create_table :videos do |t|
      t.string :video_id
      t.string :video_name
      t.string :release_date
      t.string :length
      t.string :director
      t.string :maker
      t.string :label
      t.string :rating
      t.string :img
      t.timestamps
    end
  end
end
