require 'rails_helper'

RSpec.describe YoutubeVideoVotesController, type: :controller do
  describe 'POST #vote' do
    let(:yt_video) { create(:youtube_video) }

    context 'with logged-in user' do
      let(:user) { create(:user) }

      before do
        login_user(user)
      end

      it 'should `up vote` a shared video' do
        params = { youtube_video_id: yt_video.id, vote: 'up', format: :js}
        expect { post :vote, xhr: true, params: params }.to change(YoutubeVideoVote, :count).by(1)
      end

      it 'should `down vote` a shared video' do
        params = { youtube_video_id: yt_video.id, vote: 'down', format: :js}
        expect { post :vote, xhr: true, params: params }.to change(YoutubeVideoVote, :count).by(1)
      end

      it 'should not vote with invalid vote parameter' do
        post :vote, xhr: true, params: { youtube_video_id: yt_video.id, vote: 'down_vote', format: :js}
        res = response.parsed_body
        expect(res['status']).to eq(400)
        expect(res['errors'].count).not_to eq(0)
        expect(res['errors']['vote']).to eq(['is not included in the list'])

        post :vote, xhr: true, params: { youtube_video_id: yt_video.id, vote: '', format: :js}
        res = response.parsed_body
        expect(res['status']).to eq(400)
        expect(res['errors'].count).not_to eq(0)
        expect(res['errors']['vote']).to eq(['can\'t be blank', 'is not included in the list'])
      end

      it 'should not vote an already voted video' do
        expect { post :vote, xhr: true, params: {youtube_video_id: yt_video.id, vote: 'down', format: :js}}.to change(YoutubeVideoVote, :count).by(1)

        post :vote, xhr: true, params: {youtube_video_id: yt_video.id, vote: 'down', format: :js}
        res = response.parsed_body
        expect(res['status']).to eq(400)
        expect(res['errors'].count).not_to eq(0)
        expect(res['errors']['vote']).to eq([I18n.t('youtube_video_vote.already_voted')])
      end
    end

    context 'without logged-in user' do
      it 'should not vote' do
        post :vote, xhr: true, params: { youtube_video_id: yt_video.id, vote: 'up' }
        expect(YoutubeVideoVote.count).to eq(0)
        parsed_response = response.parsed_body
        expect(response.status).to eq(401)
        expect(parsed_response).to eq(I18n.t('user.unauthorized'))
      end
    end
  end
end