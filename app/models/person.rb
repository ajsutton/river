# -*- encoding : utf-8 -*-
class Person < ActiveRecord::Base
    include CustomFields
    belongs_to :church

    validates :church, presence: true
    validates :first_name, presence: true
    validates :last_name, presence: true

    def Person.where_view(view)
        Person.where(church: view.church)
    end

    def name
        "#{first_name} #{last_name}"
    end
end
