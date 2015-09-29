# -*- encoding : utf-8 -*-
FactoryGirl.define do
  factory :custom_field do |f|
    church
    
    applies_to 'person'
  end
  
  factory :field, class: Hash do |f|
    sequence(:name) { |n| "field#{n}" }
    sequence(:id) { |n| "#{n}" }
    type 'string'
    required false
    
    initialize_with { attributes } 
  end
end

