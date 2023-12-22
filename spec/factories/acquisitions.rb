# spec/factories/acquisitions.rb

FactoryBot.define do
  factory :acquisition do
    name { 'Some Acquisition' }
    amount { 100 }
    association :author, factory: :user # Asegúrate de que esta línea coincida con tu asociación en el modelo Acquisition.

    # Si tu modelo Acquisition tiene más atributos, asegúrate de incluirlos aquí con valores válidos.
  end
end
