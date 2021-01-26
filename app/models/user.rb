class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :youtube_videos, dependent: :destroy, inverse_of: :user
  has_many :youtube_video_votes, dependent: :destroy, inverse_of: :user

  def get_vote_by(yt_video_id)
    vote = youtube_video_votes.by_yt_video_id(yt_video_id).take&.vote
    return nil if vote.blank? || vote == 'no'
    vote
  end
end
