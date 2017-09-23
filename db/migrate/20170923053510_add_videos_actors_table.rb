class AddVideosActorsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :actors_videos, id: false do |t|
      t.belongs_to :video, index: true
      t.belongs_to :actor, index: true
    end
  end
end
