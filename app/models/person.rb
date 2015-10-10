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
                value = condition['filterValue'][0]
                case condition['operator']
                when 'equal'
                    operator = '='
                when 'begins_with'
                    operator = 'LIKE'
                    value = "#{value}%"
                when 'not_begins_with'
                    operator = 'NOT LIKE'
                    value = "#{value}%"
                when 'contains'
                    operator = 'LIKE'
                    value = "%#{value}%"
                when 'not_contains'
                    operator = 'NOT LIKE'
                    value = "%#{value}%"
                else
                    throw "invalid operator #{operator}"
                end

                if column_names.include? field_name
                    matches = matches.where("#{field_name} #{operator} ?", value)
                else
                    throw "Invalid field name"
                end
            end
        end
        matches
    end

    def name
        "#{first_name} #{last_name}"
    end
end
