# -*- encoding : utf-8 -*-
class Comment < ActiveRecord::Base
    belongs_to :church
    belongs_to :person
    belongs_to :user
end
