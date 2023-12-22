class Acquisition < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_and_belongs_to_many :categories


  validates :name, presence: true


  validates :amount, numericality: { less_than_or_equal_to: 99_999_999.99, greater_than_or_equal_to: 0 }
end
