# -*- encoding : utf-8 -*-
class Field < ActiveRecord::Base
  belongs_to :church
  
  validates :church, presence: true
  validates :applies_to, presence: true, inclusion: { in: %w(person) }
  validates :type, presence: true, inclusion: { in: %w(string boolean integer date) }
  validates :name, presence: true, uniqueness: { scope: [ :church, :applies_to ] }
  
  after_initialize :init
  
  def init
    self.required = false if self.required.nil?
  end
end

