FactoryBot.define do
  factory :user do
    confirmed_at Time.zone.now
    email
    name
    password "password"
    password_confirmation "password"
    phone
  end
end
