# -*- encoding : utf-8 -*-
module DslUtil
  class PeopleDriver
    include Capybara::DSL
    include ::RSpec::Matchers
    include DslUtil

    def initialize(people)
      @people = people
    end

    def add(personAlias, options = {})
      params = parse_params(options, {
        first_name: 'John',
        last_name: 'Doe',
        fields: {}
      })

      person = @people.get_or_create personAlias do |uniqueKey|
        { first_name: params[:first_name], last_name: params[:last_name], fields: params[:fields] }
      end

      open_people_index
      click_link('Add')
      fill_in_details person
      click_button 'Create Person'
    end

    def edit(personAlias, options = {})
      params = parse_params(options, {
        first_name: 'John',
        last_name: 'Doe'
      })

      person = @people.get personAlias

      open_people_index
      click_link name_for(person)

      person[:first_name] = params[:first_name]
      person[:last_name] = params[:last_name]

      fill_in_details person
      click_button 'Update Person'
    end

    def has_people(*expected_people)
      open_people_index

      actual_names = page.all('.people .name').map { |el| el.text }
      expected_names = expected_people.map do |personAlias|
        name_for @people.get(personAlias)
      end
      expect(actual_names).to eq(expected_names)
    end

    def navigate_to_index(options = {})
      params = parse_params(options, {
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

    def name_for(person)
      "#{person[:first_name]} #{person[:last_name]}"
    end

    def fill_in_details(person)
      fill_in 'person_first_name', :with => person[:first_name]
      fill_in 'person_last_name', :with => person[:last_name]
      (person[:fields] || {}).each do |key, value|
        fill_in "fields_#{key}", :with => value
      end
    end
  end
end
