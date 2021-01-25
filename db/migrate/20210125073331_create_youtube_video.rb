class CreateYoutubeVideo < ActiveRecord::Migration[6.1]
  def change
    create_table :youtube_videos do |t|
      t.references :user, foreign_key: true
      t.string :url
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
