class User < ApplicationRecord
    # has_many :plants, dependent: :destroy
    has_many :tasks, dependent: :destroy
    has_one :garden, dependent: :destroy
    has_many :plants, through: :garden
    has_many :plants, through: :tasks
    validates :username, uniqueness: true, presence: true
    validates :password, presence: true
    
    has_secure_password

    def garden_name=(param)
    
        self.garden = Garden.create(garden_name: param['garden_name'], user_id: self.id)
    end

    def self.other_users(userCurrent)
        # return an array where the current user is not in it
        
        self.all.select do |user|
            user.id != userCurrent.id
        end
    end
  
end
