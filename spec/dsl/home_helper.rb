class HomeDriver
  include Capybara::DSL
  include ::RSpec::Matchers

  def login
    visit('/')
    find('.navbar .login').click
    fill_in 'name', :with => 'John Doe'
    fill_in 'email', :with => 'john@doe.com'
    click_button 'Sign In'
  end
  
  def verify_login_present
    visit('/')
    expect(find('.jumbotron')).to have_css('.login')
    expect(find('.navbar')).to have_css('.login')
  end
  
  def verify_logout_present
    expect(find('.navbar')).to have_css('.logout')
  end
end

