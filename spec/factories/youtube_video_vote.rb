FactoryBot.define do
  factory :youtube_video_vote do
    vote { YoutubeVideoVote.votes[:up] }
    user
    youtube_video
  end
end
