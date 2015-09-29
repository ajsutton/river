# -*- encoding : utf-8 -*-
class View < ActiveRecord::Base
  belongs_to :church
  
  validates :name, presence: true, uniqueness: { scope: [ :church, :applies_to ] }
  validates :fields, presence: true
  validates :church, presence: true
  validates :applies_to, inclusion: { in: %w(person) }
end
