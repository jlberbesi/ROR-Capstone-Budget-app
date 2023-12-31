require 'rails_helper'

RSpec.describe CategoryAcquisition, type: :model do
  describe 'associations' do
    it { should belong_to(:category) }
    it { should belong_to(:acquisition) }
  end
end
