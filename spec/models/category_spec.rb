require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_and_belong_to_many(:acquisitions) }
  end

 
end
