class CreateUsersVideos < ActiveRecord::Migration[5.0]
  def change
    create_table :users_videos do |t|
      t.belongs_to :user, index: true
      t.belongs_to :video, index: true
    end

    add_index :users_videos, [:user_id, :video_id], unique: true
  end
end
