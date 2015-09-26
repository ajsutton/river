FactoryGirl.define do
  factory :church do |f|
    f.name 'My Church'
    sequence(:shortname) { |n| "church#{n}" }
  end
end