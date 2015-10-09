# -*- encoding : utf-8 -*-
class Person < ActiveRecord::Base
    include CustomFields
    belongs_to :church

    validates :church, presence: true
    validates :first_name, presence: true
    validates :last_name, presence: true

    def Person.where_view(view)
        matches = Person.where(church: view.church)
        if !view.filters.nil?
            view.filters.each do |rule|
                condition = rule['condition']
                field_name = condition['field']
                value = condition['filterValue']
                matches = matches.where(field_name => value[0])
            end
        end
        matches
    end

    def name
        "#{first_name} #{last_name}"
    end
end
