# -*- encoding : utf-8 -*-
class Church < ActiveRecord::Base
  validates :name, presence: true
  validates :shortname, presence: true, format: {with: /\A[a-zA-Z0-9]+\z/, message: 'only allows letters and numbers'}, length: { in: 1..16 }, uniqueness: true
  
end

