require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { FactoryGirl.create :category }
  subject { category }

  describe 'with all valid values' do
    it { is_expected.to be_valid }
  end

  describe 'without a title' do
    before { category.title = '' }
    it { is_expected.not_to be_valid }
  end

  describe 'with less than zero refund percentage' do
    before { category.refund_percentage = -10 }
    it { is_expected.not_to be_valid }
  end

  describe 'with zero refund percentage' do
    before { category.refund_percentage = 0 }
    it { is_expected.not_to be_valid }
  end

  describe 'with just above zero refund percentage' do
    before { category.refund_percentage = 1 }
    it { is_expected.to be_valid }
  end

  describe 'with maximum refund percentage' do
    before { category.refund_percentage = 100 }
    it { is_expected.to be_valid }
  end

  describe 'with just over maximum refund percentage' do
    before { category.refund_percentage = 101 }
    it { is_expected.not_to be_valid }
  end

  describe 'associations' do
    it { is_expected.to have_many :refund_requests }
  end

end
