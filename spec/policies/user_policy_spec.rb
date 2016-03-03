require 'rails_helper'

RSpec.describe UserPolicy do
  subject { UserPolicy.new(user, User) }

  context 'when logged in as admin' do
    let(:user) { FactoryGirl.build :user, admin: true }
    it { is_expected.to permit_action(:index) }
  end

  context 'when logged in as normal user' do
    let(:user) { FactoryGirl.build :user }
    it { is_expected.not_to permit_action(:index) }
  end

  context 'when logged in as normal user' do
    let(:user) { nil }
    it { is_expected.not_to permit_action(:index) }
  end

end
