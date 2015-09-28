# -*- encoding : utf-8 -*-
module DslUtil
  class AdminDriver
    include Capybara::DSL
    include ::RSpec::Matchers

    def add_person_field(options = {})
      edit_people_fields
      
    end
    
    private
    
    def edit_people_fields
      find('.navbar').click_link 'Admin'
    end
  end
end