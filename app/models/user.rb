class User < ApplicationRecord





    # check is email is given and it is unique
    validates :email, presence: true, uniqueness: true,
    format: /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

    # Adds attribute accessors to the user model for password and password_confirmation
    # Validates presence of password and password matching with password_confirmation if present
    # Encrypts the password and stores it in password_digest using the bcrypt gem
    has_secure_password


    def full_name
        "#{first_name} #{last_name}"
    end
end
