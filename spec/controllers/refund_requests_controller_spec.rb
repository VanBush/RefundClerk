require 'rails_helper'

RSpec.describe RefundRequestsController, type: :controller do
  let(:users) { FactoryGirl.create_list :user, 2 }
  let(:category) { FactoryGirl.create :category }
  let(:admin) { FactoryGirl.create :user, admin: true }
  let(:request_params) { Hash.new }
  before do
    users.each do |user|
      FactoryGirl.create :refund_request, category: category, user: user
    end
  end

  subject { response }

  shared_examples 'successfully renders template' do |template|
    it { is_expected.to have_http_status(200) }
    it { is_expected.to render_template(template) }
  end

  shared_examples 'redirects to sessions#new if not logged in' do |method, action|
    before { controller.stub(:current_user).and_return(nil)
             send method, action, request_params }
    it { is_expected.to redirect_to(new_user_session_url) }
  end


  describe 'GET #index' do
    it_has_behavior 'redirects to sessions#new if not logged in', :get, :index

    context 'when logged in as an user' do
      before { controller.stub(:current_user).and_return(users.first)
               get :index }
      it_has_behavior 'successfully renders template', :index
    end

    context 'when logged in as admin' do
      before { controller.stub(:current_user).and_return(admin)
               get :index }
      it_has_behavior 'successfully renders template', :index
    end
  end

  describe 'GET #show' do
    let(:request_params) { { id: RefundRequest.first.id } }
    it_has_behavior 'redirects to sessions#new if not logged in', :get, :show

    context 'when logged in as an user' do
      context 'and accessing that user\'s item' do
        before { controller.stub(:current_user).and_return(users.first)
                 get :show, id: users.first.refund_requests.first }
        it_has_behavior 'successfully renders template', :show
      end

      context 'and accessing another user\'s item' do
        before { controller.stub(:current_user).and_return(users.first)
                 get :show, id: users.second.refund_requests.first }
        it { is_expected.to have_http_status(403) }
      end
    end

    context 'when logged in as admin' do
      before { controller.stub(:current_user).and_return(admin)
               get :show, id: users.second.refund_requests.first }
      it_has_behavior 'successfully renders template', :show
    end
  end

  # describe 'GET #new' do
  #   it_has_behavior 'redirects to sessions#new if not logged in', :get, :new
  #
  #   context 'when logged in' do
  #     it 'should be ok'
  #   end
  # end
  #
  # describe 'POST #create' do
  #   context 'when not logged in' do
  #     it 'should redirect to sessions#new'
  #   end
  #
  #   context 'when logged in' do
  #     it 'should be ok'
  #     it 'should create a record'
  #   end
  # end
  #
  # describe 'GET #edit' do
  #   context 'when not logged in' do
  #     it 'should redirect to sessions#new'
  #   end
  #
  #   context 'when logged in' do
  #     context 'as the item\'s owner' do
  #       it 'should be ok'
  #       it 'should show the item\'s title'
  #     end
  #
  #     context 'as someone else' do
  #       it 'should be unauthorized'
  #     end
  #   end
  # end
  #
  # describe 'PATCH #update' do
  #   context 'when not logged in' do
  #     it 'should redirect to sessions#new'
  #   end
  #
  #   context 'when logged in' do
  #     context 'as the item\'s owner' do
  #       it 'should be ok'
  #       it 'should update the item'
  #     end
  #
  #     context 'as someone else' do
  #       it 'should be unauthorized'
  #     end
  #   end
  # end
  #
  # describe 'DELETE #destroy' do
  #   context 'when not logged in' do
  #     it 'should redirect to sessions#new'
  #   end
  #
  #   context 'when logged in' do
  #     context 'as the item\'s owner' do
  #       it 'should be ok'
  #       it 'should update the item'
  #     end
  #
  #     context 'as someone else' do
  #       it 'should be unauthorized'
  #     end
  #   end
  # end

end
