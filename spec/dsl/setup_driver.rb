# -*- encoding : utf-8 -*-
module DslUtil
  class SetupDriver
    include Capybara::DSL
    include ::RSpec::Matchers
    
    def initialize(churches, home)
      @churches = churches
      @home = home
    end
    
    def create_church(churchAlias, options = {})
      params = DslUtil.params(options, {
        name: 'My Church'
      })
      
      church = @churches.get_or_create churchAlias do |shortname|
        { name: params[:name], shortname: shortname }
      end
      
      fill_in 'church_name', :with => church[:name]
      fill_in 'church_shortname', :with => church[:shortname]
      click_button 'Create Church'
    end
    
    def login_with_church(userAlias, churchAlias, options = {})
      params = DslUtil.params(options, {
        church_name: 'My Church',
        user_name: 'John Doe',
        email_domain: 'example.com'
      })
      
      @home.login userAlias, { name: params[:user_name], email_domain: params[:email_domain] }
      create_church(churchAlias, { name: params[:church_name] })
    end
  end
end

