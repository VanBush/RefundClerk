require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:user) { FactoryGirl.create :user }
  let(:admin) { FactoryGirl.create :user, admin: true }
  let(:category) { FactoryGirl.create :category }
  let(:request_params) { {} }

  subject { response }

  shared_examples 'denies access for non-admins' do |method, action|
    context 'when logged in as normal user' do
      before { controller.stub(:current_user).and_return(user)
               send method, action, request_params }
      it { is_expected.to have_http_status(302) }
    end

    it_has_behavior 'renders devise/sessions/new if not logged in', method, action
  end

  describe 'GET #index' do
    context 'when logged in' do
      before { controller.stub(:current_user).and_return(user) }
      it_has_behavior 'successfully renders template', :get, :index
    end

    it_has_behavior 'renders devise/sessions/new if not logged in', :get, :index
  end

  describe 'GET #new' do
    let(:request_params) { { id: category.id } }
    it_has_behavior 'denies access for non-admins', :get, :new

    context 'when logged in as admin' do
      before { controller.stub(:current_user).and_return(admin) }
      it_has_behavior 'successfully renders template', :get, :new
    end
  end

  describe 'POST #create' do
    let(:request_params) { { category: FactoryGirl.attributes_for(:category) } }
    it_has_behavior 'denies access for non-admins', :post, :create

    context 'when logged in as admin' do
      before { controller.stub(:current_user).and_return(admin)
               post :create, request_params }
      it { expect(Category.count).to eq(1) }
    end
  end

  describe 'GET #edit' do
    let(:request_params) { { id: category.id } }
    it_has_behavior 'denies access for non-admins', :get, :edit

    context 'when logged in as admin' do
      before { controller.stub(:current_user).and_return(admin) }
      it_has_behavior 'successfully renders template', :get, :edit
    end
  end

  describe 'PATCH #update' do
    let(:request_params) { { id: category.id,
                             category: { title: 'blabla',
                                         refund_percentage: 60 } } }
    it_has_behavior 'denies access for non-admins', :patch, :update

    context 'when logged in as admin' do
      before { controller.stub(:current_user).and_return(admin)
               patch :update, request_params }
      it { expect(Category.first.title).to eq('blabla') }
    end
  end

  describe 'DELETE #destroy' do
    let(:request_params) { { id: category.id } }
    it_has_behavior 'denies access for non-admins', :delete, :destroy

    context 'when logged in as admin' do
      before { controller.stub(:current_user).and_return(admin)
               delete :destroy, request_params }
      it { expect(Category.count).to eq(0) }
    end
  end

end
