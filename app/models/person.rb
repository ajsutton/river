# -*- encoding : utf-8 -*-
class Person < ActiveRecord::Base
    include CustomFields
    belongs_to :church

    validates :church, presence: true
    validates :first_name, presence: true
    validates :last_name, presence: true

    def self.where_view(view)
        matches = Person.where(church: view.church)
        if !view.filters.nil?
            values = []
            sql = process_group(view.filters, values, false)
            if (!sql.blank?)
                matches = matches.where(values.unshift sql)
            end
        end
        matches
    end

    def name
        "#{first_name} #{last_name}"
    end

    def self.process_group(group, values, has_condition)
        sql = ""
        group.each do |rule|
            # puts sql
            if (!sql.blank?)
                sql += rule['logical_operator'] == 'AND' ? ' AND ' : ' OR '
            end
            if rule['condition'].is_a? Array
                sql += process_group(rule['condition'], values, false)
            else
                sql += process_rule(rule, values, false)
            end
            # puts sql
        end
        sql.blank? ? sql : "(#{sql})"
    end
    private_class_method :process_group

    def self.process_rule(rule, values, has_condition)
        sql = ""
        condition = rule['condition']
        field_name = condition['field']
        operator = as_sql_operator condition['operator']
        value = as_sql_value(condition['operator'], condition['filterValue'] ? condition['filterValue'][0] : nil)

        if column_names.include? field_name
            sql += "#{field_name} #{operator} ?"
            values.push value
            has_condition = true
        else
            throw "Invalid field name"
        end
        sql
    end
    private_class_method :process_rule

    def self.as_sql_operator(condition_operator)
        case condition_operator
        when 'equal', 'is_empty'
            '='
        when 'begins_with', 'contains', 'ends_with'
            'LIKE'
        when 'not_begins_with', 'not_contains', 'not_ends_with'
            'NOT LIKE'
        when 'not_equal', 'not_is_empty'
            '!='
        else
            throw 'Invalid operator'
        end
    end
    private_class_method :as_sql_operator

    def self.as_sql_value(condition_operator, raw_value)
        case condition_operator
        when 'begins_with', 'not_begins_with'
            "#{raw_value}%"
        when 'contains', 'not_contains'
            "%#{raw_value}%"
        when 'ends_with', 'not_ends_with'
            "%#{raw_value}"
        when 'is_empty', 'not_is_empty'
            ''
        else
            raw_value
        end
    end
    private_class_method :as_sql_value
end
