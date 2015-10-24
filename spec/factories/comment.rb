# -*- encoding : utf-8 -*-
FactoryGirl.define do
  factory :comment do |f|
    church
    person
    user
    f.body 'This is a comment.'
  end
end
