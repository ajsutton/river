# -*- encoding : utf-8 -*-
class Person < ActiveRecord::Base
  belongs_to :church

  validates :church, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  after_initialize :init

  def name
    return "#{first_name} #{last_name}"
  end

  private
  def init
    self.fields = {} if self.fields.nil?
  end
end
