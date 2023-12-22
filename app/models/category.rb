class Category < ApplicationRecord
    belongs_to :user
    has_and_belongs_to_many :acquisitions
  
    validates :name, presence: true
  end
  