FactoryGirl.define do
  factory :field do |f|
    church
    
    applies_to 'people'
    type 'string'
    sequence(:name) { |n| "field#{n}" }
  end
end