require 'rails_helper'

RSpec.feature "Sessions", type: :feature do
  before { FactoryGirl.create :user, email: 'test@email.pl',
                                     password: 'sosecure' }

  context 'when entering valid credentials' do
    it 'signs in the user' do
      sign_in 'test@email.pl', 'sosecure'
      expect(page).to have_content 'Signed in'
    end
  end

  context 'when entering invalid credentials' do
    it 'refuses to sign in the user' do
      sign_in 'fake@email.pl', 'nowayjose'
      expect(page).to have_content 'Invalid email or password'
    end
  end

end
