require 'rails_helper'

RSpec.feature "Categories", type: :feature do
  let!(:user) { FactoryGirl.create :user, email: 'a@dmin.pl',
                                   password: 'admin123',
                                   admin: true }

  let!(:admin) { FactoryGirl.create :user, email: 'n@ormal.pl',
                                    password: 'normaluser' }
  let!(:category1) { FactoryGirl.create :category, title: 'kat1' }
  let!(:category2) { FactoryGirl.create :category, title: 'kat2' }
  let!(:refund_request1) { FactoryGirl.create :refund_request,
                                              title: 'abcdef',
                                              category: category1,
                                              user: user }
  let!(:refund_request2) { FactoryGirl.create :refund_request,
                                              title: 'ghijkl',
                                              category: category2,
                                              user: user }                                           

  context 'index' do
    context 'when logged in as admin' do
      before { sign_in 'a@dmin.pl', 'admin123'
               visit '/categories' }
      it 'lists the categories' do
        expect(page).to have_content('kat1')
        expect(page).to have_content('kat2')
      end

      it 'leads to the respective category when clicking on category name' do
        click_link 'kat1'
        expect(page).to have_content('abcdef')
        expect(page).not_to have_content('ghijkl')
      end

      it 'contains category edit links' do
        expect(page).to have_link('Edit', edit_category_url(category1))
        expect(page).to have_link('Edit', edit_category_url(category2))
      end
    end

    context 'when logged in as normal user' do
      before { sign_in 'n@ormal.pl', 'normaluser' }
      it 'shows authorization error' do
        visit '/categories'
        expect(page).to have_content('You are not allowed')
      end
    end
  end

  context 'creation and editing' do
    context 'when logged in as admin' do
      before { sign_in 'a@dmin.pl', 'admin123' }
      it 'new contains all the fields for a category' do
        visit '/categories/new'
        expect(page).to have_field("Title")
        expect(page).to have_field("Refund percentage")
      end

      it 'edit contains all the fields for a category' do
        visit "/categories/#{category1.id}/edit"
        expect(page).to have_field("Title")
        expect(page).to have_field("Refund percentage")
      end
    end
  end

end
