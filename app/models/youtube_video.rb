class YoutubeVideo < ApplicationRecord
  belongs_to :user
  validates :url, presence: true, format: /\A.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/i.freeze

  after_create :scrap_video_metadata
  YOUTUBE_DISPLAY_URL_PREFIX = 'https://www.youtube.com/embed'.freeze

  def scrap_video_metadata
    ScrapeYoutubeVideoMetadataJob.perform_later(id)
  end

  def youtube_video_url
    video_id = YouTubeAddy.extract_video_id(url)
    "#{YOUTUBE_DISPLAY_URL_PREFIX}/#{video_id}"
  end

  def title
    self[:title] || I18n.t('youtube_video.no_title')
  end

  def description
    self[:description] || I18n.t('youtube_video.no_description')
  end
end
