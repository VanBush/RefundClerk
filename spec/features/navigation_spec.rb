require 'rails_helper'

RSpec.feature "Navigation", type: :feature do
  before { FactoryGirl.create :user, admin: true,
                                     email: 'a@dmin.com',
                                     password: 'password'
           FactoryGirl.create :user, email: 'n@ormal.com',
                                     password: 'normaluser' }

  shared_examples 'should contain edit account and logout links' do
    subject { page }
    it { is_expected.to have_link('Edit account',
                                  edit_user_registration_path) }
    it { is_expected.to have_link('Sign out',
                                  destroy_user_session_path) }
  end

  context 'when logged in as admin' do
    before { sign_in 'a@dmin.com', 'password' }
    it 'should contain all navigation links' do
      expect(page).to have_link('All requests', href: refund_requests_path)
      expect(page).to have_link('Categories', href: categories_path)
      expect(page).to have_link('Users', href: users_path)
      expect(page).not_to have_link('My requests', href: refund_requests_path)
    end

    it_has_behavior 'should contain edit account and logout links'
  end

  context 'when logged in as normal user' do
    before { sign_in 'n@ormal.com', 'normaluser' }
    it 'should contain link to the user\'s requests' do
      expect(page).to have_link('My requests', href: refund_requests_path)
      expect(page).not_to have_link('All requests', href: refund_requests_path)
      expect(page).not_to have_link('Categories', href: categories_path)
      expect(page).not_to have_link('Users', href: users_path)
    end

    it_has_behavior 'should contain edit account and logout links'
  end

  context 'when not logged in' do
    before { visit '/' }
    it 'should contain sign in and sign up links' do
      expect(page).to have_link('Sign in', href: new_user_session_path)
      expect(page).to have_link('Sign up', href: new_user_registration_path)
    end
  end
  
end
