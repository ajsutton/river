module DslUtil
  class PeopleDriver
    include Capybara::DSL
    include ::RSpec::Matchers
    
    def initialize(people)
      @people = people
    end
    
    def add(personAlias, options = {})
      params = DslUtil.params(options, {
        first_name: 'John',
        last_name: 'Doe'
      })
      
      person = @people.get_or_create personAlias do |uniqueKey|
        { first_name: params[:first_name], last_name: params[:last_name] }
      end
      
      open_people_index
      click_link('Add')
      fill_in 'person_first_name', :with => person[:first_name]
      fill_in 'person_last_name', :with => person[:last_name]
      click_button 'Create Person'
    end
    
    def has_people(*expected_people)
      open_people_index
      
      actual_names = page.all('.people .name').map { |el| el.text }
      expected_names = expected_people.map do |personAlias|
        person = @people.get(personAlias)
        "#{person[:first_name]} #{person[:last_name]}" 
      end
      expect(actual_names).to eq(expected_names)
    end
    
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
    
    private
    def open_people_index
      find('.navbar').click_link 'People'
    end
  end
end