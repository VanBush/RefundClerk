require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.create :user }
  let(:admin) { FactoryGirl.create :user, admin: true }

  describe 'with non-unique email' do
    let(:another_user) { FactoryGirl.build :user, email: user.email }
    subject { another_user }
    it { is_expected.not_to be_valid }
  end

  describe 'with blank full name' do
    let(:another_user) { FactoryGirl.build :user, full_name: '' }
    subject { another_user }
    it { is_expected.not_to be_valid }
  end

  describe 'with one-word full name' do
    let(:another_user) { FactoryGirl.build :user, full_name: 'Mark' }
    subject { another_user }
    it { is_expected.not_to be_valid }
  end

  describe 'with all valid parameters' do
    subject { user }
    it { is_expected.to be_valid }
  end

  describe 'associations' do
    subject { user }
    it { is_expected.to have_many(:refund_requests) }
  end

end
