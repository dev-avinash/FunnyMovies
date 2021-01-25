class PagesController < ApplicationController
  def index
    @yt_videos = YoutubeVideo.order(created_at: :desc).page params[:page]
  end
end
