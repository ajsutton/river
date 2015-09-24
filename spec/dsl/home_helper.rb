module Dsl
  class HomeDriver
    include Capybara::DSL
    include ::RSpec::Matchers

    def login(userAlias, options = {})
      params = DslUtil.params(options, {
        name: 'John Doe',
        email: 'john@example.com'
      })
      
      visit('/')
      find('.navbar .login').click
      fill_in 'name', :with => params[:name]
      fill_in 'email', :with => params[:email]
      click_button 'Sign In'
    end
  
    def logout
      visit('/')
      find('.navbar .logout').click
    end
  
    def login_present!
      visit('/')
      expect(find('.jumbotron')).to have_css('.login')
      expect(find('.navbar')).to have_css('.login')
    end
  
    def logout_present!
      expect(find('.navbar')).to have_css('.logout')
    end
  end
end