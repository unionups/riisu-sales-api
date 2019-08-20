require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has secure token' do
    expect(User.create(phone_number: Phonelib.parse(Faker::PhoneNumber.phone_number_with_country_code).e164).auth_token).to be_present
  end
end
