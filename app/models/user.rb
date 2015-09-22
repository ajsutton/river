class User < ActiveRecord::Base
  belongs_to :church
  has_many :identities
  
  def self.create_with_omniauth(info)
    create(username: info['uid'])
  end
end
