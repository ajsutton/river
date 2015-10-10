# -*- encoding : utf-8 -*-
require 'rails_helper'

describe Person, type: :model do
    it 'should have a valid factory' do
        expect(create(:person)).to be_valid
    end

    it 'requires a church' do
        expect(build(:person, church: nil)).to be_invalid
    end

    it 'requires first name' do
        expect(build(:person, first_name: nil)).to be_invalid
    end

    it 'requires last name' do
        expect(build(:person, last_name: nil)).to be_invalid
    end

    it 'creates a name from first and last names' do
        expect(build(:person, first_name: 'Roger', last_name: 'Smith').name).to eq('Roger Smith')
    end

    it 'stores fields by id' do
        field = build(:field, name: 'Field1')
        church = create(:church)
        schema = create(:field_schema, fields: [field], applies_to: 'person', church: church)
        person = create(:person, church: church)
        person.set_field('Field1', 'My Value')
        expect(person.fields[field[:id]]).to eq 'My Value'
        expect(person.get_field('Field1')).to eq 'My Value'
    end

    it 'stores arbitrary fields' do
        fields = { 'f' => true, 'a field!@#$%^&*()[]{}_-="\'' => 'b💩', 'd💩' => 3 }
        person = build(:person, fields: fields)
        expect(person.save).to be true
        person.reload
        expect(person.fields).to eq(fields)
    end

    describe 'where_view' do
        before :each do
            @church = create(:church)
            @other_church = create(:church)
            @person1 = create(:person, first_name: 'Joe', last_name: 'Black', church: @church)
            @person2 = create(:person, first_name: 'Jo', last_name: 'White', church: @church)
            @person3 = create(:person, first_name: 'Luke', last_name: 'Brown', church: @church)
            @person4 = create(:person, first_name: 'Lynn', last_name: 'Blue', church: @other_church)
            @view = create(:view, church: @church)
        end

        it 'only includes people from the current church' do
            expect(Person.where_view(@view)).to contain_exactly(@person1, @person2, @person3)
        end

        describe 'simple filters' do
            it 'applies equal filters' do
                @view.filters = [
                    {
                        element_rule_id:"rule_filters_1",
                        condition: {
                            filterType: "text", field:"first_name", operator:"equal", filterValue:["Luke"]
                        },
                        logical_operator:"AND"
                    }
                ]
                expect(Person.where_view(@view)).to contain_exactly(@person3)
            end

            it 'applies not_equal filters' do
                @view.filters = [
                    {
                        element_rule_id:"rule_filters_1",
                        condition: {
                            filterType: "text", field:"first_name", operator:"not_equal", filterValue:["Luke"]
                        },
                        logical_operator:"AND"
                    }
                ]
                expect(Person.where_view(@view)).to contain_exactly(@person1, @person2)
            end

            it 'applies begins_with filters' do
                @view.filters = [
                    {
                        element_rule_id:"rule_filters_1",
                        condition: {
                            filterType: "text", field:"first_name", operator:"begins_with", filterValue:["Jo"]
                        },
                        logical_operator:"AND"
                    }
                ]
                expect(Person.where_view(@view)).to contain_exactly(@person1, @person2)
            end

            it 'applies not_begins_with filters' do
                @view.filters = [
                    {
                        element_rule_id:"rule_filters_1",
                        condition: {
                            filterType: "text", field:"first_name", operator:"not_begins_with", filterValue:["Jo"]
                        },
                        logical_operator:"AND"
                    }
                ]
                expect(Person.where_view(@view)).to contain_exactly(@person3)
            end

            it 'applies contains filters' do
                @view.filters = [
                    {
                        element_rule_id:"rule_filters_1",
                        condition: {
                            filterType: "text", field:"first_name", operator:"contains", filterValue:["o"]
                        },
                        logical_operator:"AND"
                    }
                ]
                expect(Person.where_view(@view)).to contain_exactly(@person1, @person2)
            end

            it 'applies not_contains filters' do
                @view.filters = [
                    {
                        element_rule_id:"rule_filters_1",
                        condition: {
                            filterType: "text", field:"first_name", operator:"not_contains", filterValue:["o"]
                        },
                        logical_operator:"AND"
                    }
                ]
                expect(Person.where_view(@view)).to contain_exactly(@person3)
            end


            it 'applies ends_with filters' do
                @view.filters = [
                    {
                        element_rule_id:"rule_filters_1",
                        condition: {
                            filterType: "text", field:"first_name", operator:"ends_with", filterValue:["e"]
                        },
                        logical_operator:"AND"
                    }
                ]
                expect(Person.where_view(@view)).to contain_exactly(@person1, @person3)
            end

            it 'applies not_ends_with filters' do
                @view.filters = [
                    {
                        element_rule_id:"rule_filters_1",
                        condition: {
                            filterType: "text", field:"first_name", operator:"not_ends_with", filterValue:["e"]
                        },
                        logical_operator:"AND"
                    }
                ]
                expect(Person.where_view(@view)).to contain_exactly(@person2)
            end

            it 'applies is_empty filters' do
                @view.filters = [
                    {
                        element_rule_id:"rule_filters_1",
                        condition: {
                            filterType: "text", field:"first_name", operator:"is_empty"
                        },
                        logical_operator:"AND"
                    }
                ]
                expect(Person.where_view(@view)).to contain_exactly()
            end

            it 'applies not_is_empty filters' do
                @view.filters = [
                    {
                        element_rule_id:"rule_filters_1",
                        condition: {
                            filterType: "text", field:"first_name", operator:"not_is_empty"
                        },
                        logical_operator:"AND"
                    }
                ]
                expect(Person.where_view(@view)).to contain_exactly(@person1, @person2, @person3)
            end
        end

        describe 'combined filters' do
            it 'should apply two conditions with AND' do
                @view.filters = [
                    {
                        element_rule_id: "rule_filters_1",
                        condition: {
                            filterType: "text",
                            field: "first_name",
                            operator: "begins_with",
                            filterValue: ["Jo"]
                        },
                        logical_operator: "AND"
                    },
                    {
                        element_rule_id: "rule_filters_2",
                        condition: {
                            filterType: "text",
                            field: "last_name",
                            operator: "equal",
                            filterValue: ["White"]
                        },
                        logical_operator: "AND"
                    }
                ]
                expect(Person.where_view(@view)).to contain_exactly(@person2)
            end
        end
    end
end
