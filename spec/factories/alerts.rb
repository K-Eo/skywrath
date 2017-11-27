FactoryBot.define do
  factory :alert do
    association :author, factory: :user
    association :assisted_by, factory: :user
    association :closed_by, factory: :user
  end
end
