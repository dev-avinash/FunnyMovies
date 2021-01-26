class YoutubeVideoVotesController < ApplicationController
  before_action :authenticate_user!

  def vote
    outcome = YoutubeVideoVoteInteraction.run(params.merge(user: current_user))
    if outcome.valid?
      @user_vote = outcome.result
      @vote_icon_name = current_user.get_vote_by(@user_vote.youtube_video_id)
      respond_to do |format|
        format.js
      end
    else
      render json: { status: 400, errors: outcome.errors.messages }
    end
  end

  private

  def vote_params
    params.permit(:youtube_video_id, :vote)
  end
end
