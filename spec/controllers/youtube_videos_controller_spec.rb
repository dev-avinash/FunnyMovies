require 'rails_helper'

RSpec.describe YoutubeVideosController, type: :controller do

  describe 'POST #create' do
    let(:youtube_url) { 'https://www.youtube.com/watch?v=M5NVwuyk2uM' }

    context 'with logged-in user' do
      let(:user) { create(:user) }
      before do
        login_user(user)
      end

      it 'should share a youtube video' do
        params = { youtube_video: { url: youtube_url } }
        expect { post :create, params: params }.to change(YoutubeVideo, :count).by(1)
        expect(response.status).to eq(302)
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to match(I18n.t('youtube_video.created'))
      end

      it 'should not share with empty url' do
        expect { post :create }.to change(YoutubeVideo, :count).by(0)
        expect(response.status).to eq(302)
        expect(response).to redirect_to(share_path)
        expect(flash[:notice]).to match('Url is invalid')
      end

      it 'should not share with invalid url' do
        params = { youtube_video: { url: 'wwww.facebook.com' } }
        expect { post :create, params: params }.to change(YoutubeVideo, :count).by(0)
        expect(response.status).to eq(302)
        expect(response).to redirect_to(share_path)
        expect(flash[:notice]).to match('Url is invalid')
      end
    end

    context 'with logged-out user' do
      it 'should not be able to share' do
        params = { youtube_video: { url: youtube_url } }
        post :create, params: params
        expect(YoutubeVideo.count).to eq(0)
        expect(flash[:alert]).to match(I18n.t('user.unauthorized'))
      end
    end
  end
end
