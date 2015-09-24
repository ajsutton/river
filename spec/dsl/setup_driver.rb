module DslUtil
  class SetupDriver
    include Capybara::DSL
    include ::RSpec::Matchers
    
    def initialize(churches)
      @churches = churches
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
  end
end