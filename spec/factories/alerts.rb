FactoryBot.define do
  factory :alert do
    association :author, factory: :user
    association :assignee, factory: :user
  end
end
