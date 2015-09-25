FactoryGirl.define do
  factory :person do |f|
    church
    f.first_name 'John'
    f.last_name 'Doe'
  end
end