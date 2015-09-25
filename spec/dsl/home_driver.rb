module DslUtil
  class HomeDriver
    include Capybara::DSL
    include ::RSpec::Matchers

    def initialize(users)
      @users = users
    end
    
    def on_home_page!
      expect(find('.jumbotron h1')).to have_text('Welcome')
    end
    
    def login(userAlias, options = {})
      params = DslUtil.params(options, {
        name: 'John Doe',
        emailDomain: 'example.com'
      })
      
      user = @users.get_or_create userAlias do |uniqueKey|
        { name: params[:name], email: "#{uniqueKey}@#{params[:emailDomain]}" }
      end
      
      visit('/')
      find('.navbar .login').click
      fill_in 'name', :with => user[:name]
      fill_in 'email', :with => user[:email]
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
    
    def people_component_available!
      expect(find('.navbar')).to have_link('People')
    end
    
    def people_component_unavailable!
      expect(find('.navbar')).to have_no_link('People')
    end
  end
end