RSpec.describe YoutubeVideo, type: :model do

  let(:yt_video) { build(:youtube_video) }

  before(:each) { allow_any_instance_of(YoutubeVideo).to receive(:scrap_video_metadata).and_return(true) }

  describe 'schema' do
    it { should have_db_column(:user_id).of_type(:integer) }
    it { should have_db_column(:url).of_type(:string) }
    it { should have_db_column(:title).of_type(:string) }
    it { should have_db_column(:description).of_type(:text) }
  end

  describe 'create' do
    it { expect { yt_video.save }.to change(YoutubeVideo, :count).by(1) }
  end

  describe 'validations' do
    it { expect(yt_video).to allow_value('https://youtu.be/watch?v=rsPyiZSzj3g').for(:url) }
    it { should validate_presence_of(:url) }

    it 'should not take invalid youtube url' do
      expect(yt_video).to_not allow_value('https://youtud.be/wrong_yt_url').for(:url)
      expect(yt_video.errors.full_messages.to_sentence).to eq("Url is invalid")
      expect(yt_video.errors.count).to eq(1)
    end
  end

  describe 'associations' do
    it { should have_many(:youtube_video_votes) }
    it { should belong_to(:user) }
  end

  describe 'callbacks' do
    it { is_expected.to callback(:scrap_video_metadata).after(:create) }
  end
end
