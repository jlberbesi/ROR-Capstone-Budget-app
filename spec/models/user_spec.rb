require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    user = User.new(
      name: 'Sam',
      email: 'san@example.com',
      password: 'sam123',
      password_confirmation: 'sam123'
    )
    expect(user).to be_valid
  end

  it 'is not valid without a name' do
    user = User.new(
      email: 'san@example.com',
      password: 'sam123',
      password_confirmation: 'sam123'
    )
    expect(user).to_not be_valid
  end

  it 'is not valid with a wrong password_confirmation' do
    user = User.new(
      name: 'Sam',
      email: 'san@example.com',
      password: 'sam123',
      password_confirmation: 'wrongpassword'
    )
    expect(user).to_not be_valid
  end
end
