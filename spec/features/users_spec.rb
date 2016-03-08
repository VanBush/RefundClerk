require 'rails_helper'

RSpec.feature "Users", type: :feature do
  let!(:users) { FactoryGirl.create_list :user, 5 }
  before { users.first.update(admin: true, email: 'a@dmin.com', password: 'secure99') }

  describe 'index' do
    before { sign_in 'a@dmin.com', 'secure99'
             click_link 'Users' }

    it 'should list all users' do
      users.each do |u|
        expect(page).to have_link(u.full_name, href: refund_requests_path(user: u))
      end
    end

  end

end
