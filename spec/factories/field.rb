# -*- encoding : utf-8 -*-
FactoryGirl.define do
  factory :field do |f|
    church
    
    applies_to 'person'
    data_type 'string'
    sequence(:name) { |n| "field#{n}" }
  end
end

