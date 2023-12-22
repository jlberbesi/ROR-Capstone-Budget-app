FactoryBot.define do
  factory :category do
    transient do
      custom_name { 'Category Name' }
    end

    name { custom_name }
    icon { 'Icon URL' }
    user

    after(:build) do |category, evaluator|
      category.name = evaluator.custom_name
    end
  end
end
