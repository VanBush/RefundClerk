require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:admin) { FactoryGirl.create :user, admin: true }
  let(:user) { FactoryGirl.create :user }
  let(:request_params) { {} }

  subject { response }

  describe 'GET #index' do
    it_has_behavior 'redirects to sessions#new if not logged in', :get, :index

    context 'when logged in as admin' do
      before { controller.stub(:current_user).and_return(admin) }
      it_has_behavior 'successfully renders template', :get, :index
    end

    context 'when logged in as a normal user' do
      before { controller.stub(:current_user).and_return(user)
               get :index }
      it { is_expected.to have_http_status(403) }
    end

  end
end
