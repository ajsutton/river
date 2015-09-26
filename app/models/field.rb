class Field < ActiveRecord::Base
  belongs_to :church
  
  validates :church, presence: true
  validates :applies_to, presence: true, inclusion: { in: %w(people) }
  validates :type, presence: true, inclusion: { in: %w(string boolean integer date) }
  
  after_initialize :init
  
  def init
    self.required = false if self.required.nil?
  end
end
