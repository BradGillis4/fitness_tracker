class User < ActiveRecord::Base
    has_many :posts
  
    has_secure_password #adds salt (random string added to password)
  
    validates :username, :presence => true,
                         :uniqueness => true
    validates :password, :presence => true
  end