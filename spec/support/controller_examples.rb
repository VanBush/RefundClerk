shared_examples 'successfully renders template' do |method, action|
  before { send method, action, request_params }
  # it { is_expected.to have_http_status(200) }
  it { is_expected.to render_template(action) }
end

shared_examples 'redirects to sessions#new if not logged in' do |method, action|
  before { controller.stub(:current_user).and_return(nil)
    send method, action, request_params }
  it { is_expected.to redirect_to(new_user_session_url) }
end
