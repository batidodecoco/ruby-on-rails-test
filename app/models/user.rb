class User < ApplicationRecord
    has_secure_password
    validates :username, presence: true, length: { minimum: 3, maximum: 25 }
    validates :password, presence: true, length: { minimum: 6 }
end
