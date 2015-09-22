class User < ActiveRecord::Base
  belongs_to :church
  has_many :identities
  
  validates :name, presence: true
  
  def self.create_with_omniauth(info)
    create(name: info['name'], email: info['email'])
  end
end
