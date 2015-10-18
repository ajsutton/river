# -*- encoding : utf-8 -*-
require 'rails_helper'

describe 'People Views' do
    before :each do
        setup.login_with_church :user, :church
        admin.add_person_field name: 'Custom Field 1', type: 'String'
        admin.add_person_field name: 'Custom Field 2', type: 'True/False'
        people.add :person1, fields: { 'Custom Field 1' => 'Value 1', 'Custom Field 2' => true}
    end

    it 'should create a new view' do
        people.views.create :view, fields: [ 'Custom Field 1', 'Custom Field 2']
        people.has_people :person1
        people.has_columns 'Name', 'Custom Field 1', 'Custom Field 2'
    end

    it 'should edit existing views' do
        people.views.create :view, fields: [ 'Custom Field 1' ]
        people.has_columns 'Name', 'Custom Field 1'
        people.views.edit :view, select: [ 'Custom Field 2' ], unselect: [ 'Custom Field 1' ]
        people.has_columns 'Name', 'Custom Field 2'
    end

    it 'should delete views' do
        people.views.create :view1, fields: [ 'Custom Field 1']
        people.views.create :view2, fields: [ 'Custom Field 2']

        people.views.delete :view1

        people.views.has_views :view2
        people.has_columns 'Custom Field 2'
    end
end
