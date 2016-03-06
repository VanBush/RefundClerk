shared_examples 'successfully renders template' do |method, action|
  before { send method, action, request_params }
  # it { is_expected.to have_http_status(200) }
  it { is_expected.to render_template(action) }
end

shared_examples 'renders devise/sessions/new if not logged in' do |method, action|
  before { controller.stub(:current_user).and_return(nil)
    send method, action, request_params }
  it { is_expected.to render_template('devise/sessions/new') }
end
