require 'rails_helper'

RSpec.describe RefundRequestPolicy do
  describe 'permissions' do
    let(:category) { FactoryGirl.create :category }
    let(:refund_request) { FactoryGirl.build :refund_request,
                                             category: category,
                                             user: user }

    subject { RefundRequestPolicy.new(user, refund_request) }

    shared_examples 'allows actions on a particular item' do
      it { is_expected.to permit_action(:show) }
      it { is_expected.to permit_action(:edit) }
      it { is_expected.to permit_action(:update) }
      it { is_expected.to permit_action(:destroy) }
    end

    shared_examples 'disallows actions on a particular item' do
      it { is_expected.not_to permit_action(:show) }
      it { is_expected.not_to permit_action(:edit) }
      it { is_expected.not_to permit_action(:update) }
      it { is_expected.not_to permit_action(:destroy) }
    end

    shared_examples 'allows item listing and creating' do
      it { is_expected.to permit_action(:index) }
      it { is_expected.to permit_action(:new) }
      it { is_expected.to permit_action(:create) }
    end

    shared_examples 'disallows item listing and creating' do
      it { is_expected.not_to permit_action(:index) }
      it { is_expected.not_to permit_action(:new) }
      it { is_expected.not_to permit_action(:create) }
    end

    context 'when being the refund request\'s author' do
      let(:user) { FactoryGirl.create :user }
      it_has_behavior 'allows actions on a particular item'
      it_has_behavior 'allows item listing and creating'
    end

    context 'when being someone else than the refund request\'s author' do
      let(:user) { FactoryGirl.create :user }
      before { refund_request.user = FactoryGirl.create :user }
      it_has_behavior 'disallows actions on a particular item'
      it_has_behavior 'allows item listing and creating'
    end

    context 'when being an admin' do
      let(:user) { FactoryGirl.create :user }
      let(:admin) { FactoryGirl.create :user, admin: true }
      subject { RefundRequestPolicy.new(admin, refund_request) }
      it_has_behavior 'allows actions on a particular item'
      it_has_behavior 'allows item listing and creating'
    end

    context 'when not logged in' do
      let(:user) { nil }
      it_has_behavior 'disallows actions on a particular item'
      it_has_behavior 'disallows item listing and creating'
    end
  end

  context 'scope' do
    let(:user1) { FactoryGirl.create :user }
    let(:user2) { FactoryGirl.create :user }
    let(:admin) { FactoryGirl.create :user, admin: true }
    let(:category) { FactoryGirl.create :category }
    let(:request1) { FactoryGirl.create :refund_request, category: category,
                                        user: user1 }
    let(:request2) { FactoryGirl.create :refund_request, category: category,
                                        user: user2 }

    subject { RefundRequestPolicy::Scope.new(user, RefundRequest.all).resolve }

    context 'when being an user' do
      let(:user) { user1 }
      it { is_expected.to include(request1) }
      it { is_expected.not_to include(request2) }
    end

    context 'when being an admin' do
      let(:user) { admin }
      it { is_expected.to include(request1) }
      it { is_expected.to include(request2) }
    end

  end

end
