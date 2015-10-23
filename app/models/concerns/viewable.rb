# -*- encoding : utf-8 -*-
module Viewable extend ActiveSupport::Concern
    module ClassMethods
        def schema(church)
            FieldSchema.find_by(church: church, applies_to: self.name.downcase) || FieldSchema.new(church: church, applies_to: self.name.downcase)
        end


        def where_view(view)
            matches = self.where(church: view.church)
            schema = self.schema(view.church)
            if !view.filters.nil?
                values = []
                sql = process_group(view.filters, values, false, schema)
                if (!sql.blank?)
                    matches = matches.where(values.unshift sql)
                end
            end
            matches
        end

        private
        def test()
            throw "FAIL!!!!"
        end
        def process_group(group, values, has_condition, schema)
            sql = ""
            group.each do |rule|
                if (!sql.blank?)
                    sql += rule['logical_operator'] == 'AND' ? ' AND ' : ' OR '
                end
                if rule['condition'].is_a? Array
                    sql += process_group(rule['condition'], values, false, schema)
                else
                    sql += process_rule(rule, values, false, schema)
                end
            end
            sql.blank? ? sql : "(#{sql})"
        end

        def process_rule(rule, values, has_condition, schema)
            sql = ""
            condition = rule['condition']
            field_name = condition['field']
            operator = as_sql_operator(condition['operator'])
            value = as_sql_value(condition['operator'], condition['filterValue'] ? condition['filterValue'][0] : nil)

            if schema.has_field_with_id? field_name
                sql += "fields ->> ? #{operator} ?"
                values.push field_name
                values.push value
                has_condition = true
            elsif column_names.include?(field_name)
                sql += "#{field_name} #{operator} ?"
                values.push value
                has_condition = true
            else
                throw "Invalid field name"
            end
            sql
        end

        def as_sql_operator(condition_operator)
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

        def as_sql_value(condition_operator, raw_value)
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
    end
end
