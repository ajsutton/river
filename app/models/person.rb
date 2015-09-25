class Person < ActiveRecord::Base
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  
  def name
    return "#{first_name} #{last_name}"
  end
end
