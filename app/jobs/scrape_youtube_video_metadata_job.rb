class ScrapeYoutubeVideoMetadataJob < ActiveJob::Base
  sidekiq_options queue: 'yt_metadata_scraper', retry: 5, backtrace: true

  def perform(yt_video_id)
    yt_video = YoutubeVideo.find_by(id: yt_video_id)
    return unless yt_video

    video_info = VideoInfo.new(yt_video.url)
    return unless video_info

    yt_video.update(title: video_info&.title, description: video_info&.description)
  end
end
