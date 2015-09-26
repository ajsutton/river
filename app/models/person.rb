# -*- encoding : utf-8 -*-
class Person < ActiveRecord::Base
  belongs_to :church
  
  validates :church, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  
  def name
    return "#{first_name} #{last_name}"
  end
end

