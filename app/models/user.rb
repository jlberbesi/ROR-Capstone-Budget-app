class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :categories
  has_many :acquisitions

  validates :name, presence: true
end
