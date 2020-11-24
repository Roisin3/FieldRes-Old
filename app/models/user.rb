class User < ActiveRecord::Base
    has_secure_password
    validates :email, uniqueness: true
    has_many :events
    has_many :requirements, through: :events   

end
