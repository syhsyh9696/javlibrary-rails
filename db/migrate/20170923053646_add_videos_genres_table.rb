class AddVideosGenresTable < ActiveRecord::Migration[5.0]
  def change
    create_table :genres_videos, id: false do |t|
      t.belongs_to :video, index: true
      t.belongs_to :genre, index: true
    end
  end
end
