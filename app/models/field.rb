class Field < ActiveRecord::Base
  belongs_to :church
  
  validates :church, presence: true
  validates :applies_to, presence: true
  validates :type, presence: true
  
  after_initialize :init
  
  def init
    self.required = false if self.required.nil?
  end
end
