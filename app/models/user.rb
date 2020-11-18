class User < ActiveRecord::Base
    has_secure_password
    validates :email, uniqueness: true
    has_many :events
    has_many :requirements, through: :events

    def self.find_or_create_by_omniauth(auth_hash)
        self.where(email: auth_hash['info']['email']).first_or_create do |u|
            u.name = auth_hash['info']['name']
            u.password_digest
        end
    end
    
    

end
