FactoryBot.define do
  factory :clause do
    id {Faker::Number.unique.number}
    text {Faker::Name.unique.name }
  end
end