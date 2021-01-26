class YoutubeVideoVoteInteraction < ActiveInteraction::Base
  integer :youtube_video_id
  string :vote
  object :user

  validates :vote, presence: true, inclusion: %w[up down]

  set_callback :execute, :before, -> { find_yt_video; find_existing_vote; }

  def execute
    yt_video_vote = user.youtube_video_votes.build(youtube_video_id: youtube_video_id,
                                                   vote: vote)

    errors.merge!(yt_video_vote.errors) unless yt_video_vote.save
    yt_video_vote
  end

  def find_existing_vote
    errors.add(:vote, I18n.t('youtube_video_vote.already_voted')) if user.youtube_video_votes.exists?(youtube_video_id: youtube_video_id)
  end

  def find_yt_video
    yt_video = YoutubeVideo.find_by(id: youtube_video_id)
    errors.add(:youtube_video, I18n.t('youtube_video.not_found')) if yt_video.nil?
  end
end
