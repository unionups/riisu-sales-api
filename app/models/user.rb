class User < ApplicationRecord
  rolify
  after_create :assign_default_role
  has_secure_token :auth_token
  validates :phone_number, phone: { possible: true, allow_blank: false, types: [:mobile]}#, countries: [:us]}

  private 

  def assign_default_role
    self.add_role(:user) if self.roles.blank?
  end
end
