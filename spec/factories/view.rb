# -*- encoding : utf-8 -*-
FactoryGirl.define do
  factory :view do |f|
    church
    applies_to 'person'
    sequence(:name){ |n| "View #{n}" }
    fields [ 'first_name' ]
  end
end
