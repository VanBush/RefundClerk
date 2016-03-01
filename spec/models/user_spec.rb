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

  describe 'total refunds for a month' do
    let(:category1) { FactoryGirl.create :category, refund_percentage: 30 }
    let(:category2) { FactoryGirl.create :category, refund_percentage: 70 }
    let(:another_user) { FactoryGirl.build :user, email: user.email }
    subject { user }

    before do
      # these should be counted:
      FactoryGirl.create :refund_request, category: category1,
                          status: :accepted, amount: 50, user: user,
                          created_at: '1 May 2015'
      FactoryGirl.create :refund_request, category: category2,
                          status: :accepted, amount: 100, user: user,
                          created_at: '10 May 2015'
      # these shouldn't be counted (another month, not accepted, another user)
      FactoryGirl.create :refund_request, category: category2,
                          status: :accepted, amount: 150, user: user,
                          created_at: '20 Jun 2015'
      FactoryGirl.create :refund_request, category: category1,
                          status: :pending, amount: 50, user: user,
                          created_at: '10 May 2015'
      FactoryGirl.create :refund_request, category: category1,
                          status: :accepted, amount: 25, user: another_user,
                          created_at: '10 May 2015'
    end

    it { is_expected.to respond_to(:total_refunds).with(2).arguments }

    it 'should return the correct total for the user\'s refunds' do
      expect(user.total_refunds(2015, 5)).to eql(85)
    end

  end

end
