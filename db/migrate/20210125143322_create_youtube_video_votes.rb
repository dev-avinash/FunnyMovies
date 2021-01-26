class CreateYoutubeVideoVotes < ActiveRecord::Migration[6.1]
  def change
    create_table :youtube_video_votes do |t|
      t.references :youtube_video, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :vote
      t.timestamps
    end
  end
end
