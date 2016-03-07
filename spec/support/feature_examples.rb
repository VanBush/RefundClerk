def sign_in(email, password)
  visit '/'
  within 'form' do
    fill_in 'Email', with: email
    fill_in 'Password', with: password
  end
  click_button 'Log in'
end

shared_context 'Rendered partial' do
  let!(:rendered) { render partial: partial }
  let(:page) { Capybara::Node::Simple.new(rendered) }
end