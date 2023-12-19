class CategoryAcquisition < ApplicationRecord
  belongs_to :category, class_name: 'Category'
  belongs_to :acquisition, class_name: 'Acquisition'
end
