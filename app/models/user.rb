class User < ActiveRecord::Base
  has_secure_password

  has_many :petitions

  validates :email, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  def name
    "#{first_name} #{last_name}"
  end
end
