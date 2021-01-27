require 'rails_helper'

RSpec.describe YoutubeVideoVote, type: :model do
  let(:yt_video_vote) { build(:youtube_video_vote) }

  describe 'schema' do
    it { should have_db_column(:user_id).of_type(:integer) }
    it { should have_db_column(:youtube_video_id).of_type(:integer) }
    it { should have_db_column(:vote).of_type(:integer) }
    it { should define_enum_for(:vote).with_values(%i[no up down]) }
  end

  describe 'create' do
    it { expect { yt_video_vote.save }.to change(YoutubeVideoVote, :count).by(1) }
  end

  describe 'validations' do
    it 'should not take invalid votes' do
      assert_raises ArgumentError do
        yt_video_vote.vote = "type5"
      end
    end
  end

  describe 'associations' do
    it { should belong_to(:youtube_video) }
    it { should belong_to(:user) }
  end
end