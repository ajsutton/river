module DslUtil
  class PeopleDriver
    include Capybara::DSL
    include ::RSpec::Matchers
    
    def navigate_to_index(options = {})
      params = DslUtil.params(options, {
        expect: :ok
      })
      
      visit('/people')
      
      case params[:expect]
      when :forbidden
        expect(find('h1')).to have_text('Forbidden')
      else
        throw "Unknown expectation #{params[:expect]}"
      end
    end
  end
end