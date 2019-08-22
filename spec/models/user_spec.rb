require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {create(:user)}

  it 'has secure token' do
    expect(user.auth_token).to be_present
  end

  it 'has :user role' do
    expect(user.has_role? :user).to eq true
  end

end
