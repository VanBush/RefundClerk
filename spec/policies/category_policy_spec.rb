require 'rails_helper'

RSpec.describe CategoryPolicy do
  subject { CategoryPolicy.new(user, category) }
  let(:category) { FactoryGirl.build :category }

  context 'when logged in as admin' do
    let(:user) { FactoryGirl.build :user, admin: true }
    it { is_expected.to permit_action(:index) }
    it { is_expected.to permit_action(:create) }
    it { is_expected.to permit_action(:destroy) }
    it { is_expected.to permit_action(:update) }
    it { is_expected.to permit_action(:new) }
    it { is_expected.to permit_action(:edit) }
  end

  context 'when logged in as normal user' do
    let(:user) { FactoryGirl.build :user }
    it { is_expected.not_to permit_action(:index) }
    it { is_expected.not_to permit_action(:create) }
    it { is_expected.not_to permit_action(:destroy) }
    it { is_expected.not_to permit_action(:update) }
    it { is_expected.not_to permit_action(:new) }
    it { is_expected.not_to permit_action(:edit) }
  end

  context 'when not logged in' do
    let(:user) { nil }
    it { is_expected.not_to permit_action(:index) }
    it { is_expected.not_to permit_action(:create) }
    it { is_expected.not_to permit_action(:destroy) }
    it { is_expected.not_to permit_action(:update) }
    it { is_expected.not_to permit_action(:new) }
    it { is_expected.not_to permit_action(:edit) }
  end

end
