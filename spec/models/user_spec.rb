require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  describe 'schema' do
    it { should have_db_column(:email).of_type(:string) }
    it { should have_db_column(:encrypted_password).of_type(:string) }
  end

  describe 'create' do
    it { expect { user.save }.to change(User, :count).by(1) }
  end

  describe 'validations' do
    it { expect(user).to allow_value(Faker::Internet.email).for(:email) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
    it 'should not take invalid emails' do
      expect(user).to_not allow_value('something').for(:email)
      expect(user.errors.full_messages.to_sentence).to eq('Email is invalid')
      expect(user.errors.count).to eq(1)
    end
  end

  describe 'associations' do
    it { should have_many(:youtube_videos) }
    it { should have_many(:youtube_video_votes) }
  end
end