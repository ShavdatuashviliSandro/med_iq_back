class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true

  def age
    now = Time.zone.today

    age = now.year - date_of_birth.year
    age -= 1 if date_of_birth.to_date.change(year: now.year) > now
    age
  end
end
