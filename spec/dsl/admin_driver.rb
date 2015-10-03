# -*- encoding : utf-8 -*-
module DslUtil
  class AdminDriver
    include Capybara::DSL
    include ::RSpec::Matchers
    include DslUtil

    def add_person_field(options = {})
      params = parse_params(options, {
        name: nil,
        type: 'String',
        required: false
      })
      edit_people_fields
      row = find('.fields tbody tr:last-child')
      row.fill_in 'fields[][name]', :with => params[:name]
      row.select params[:type], :from => 'fields[][type]'
      if (params[:required])
        row.check 'fields[][required]'
      else
        row.uncheck 'fields[][required]'
      end
      click_button 'Save'
    end

    private

    def edit_people_fields
      find('.navbar').click_link 'Admin'
    end
  end
end
