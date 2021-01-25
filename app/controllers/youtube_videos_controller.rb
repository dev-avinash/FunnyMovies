class YoutubeVideosController < ApplicationController
  before_action :authenticate_user!

  def new
    @yt_video = YoutubeVideo.new
  end

  def create
    yt_video = current_user.youtube_videos.build(url: params.dig(:youtube_video, :url))

    return redirect_to root_path, notice: t('youtube_video.created') if yt_video.save
    redirect_to share_path, notice: yt_video.errors.full_messages.to_sentence
  end
end
