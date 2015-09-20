class User < ActiveRecord::Base
  belongs_to :church
  has_secure_password

  validates :username, presence: true, format: {with: /\A[a-zA-Z0-9]+\z/, message: 'only allows letters and numbers'}, length: { in: 1..16 }, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
end
