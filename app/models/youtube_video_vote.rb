class YoutubeVideoVote < ApplicationRecord
  belongs_to :youtube_video
  belongs_to :user, inverse_of: :youtube_video_votes
  enum vote: %i[no up down]

  scope :by_yt_video_id, ->(yt_video_id) { where(youtube_video_id: yt_video_id) }
end