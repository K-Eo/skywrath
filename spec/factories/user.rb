FactoryBot.define do
  factory :user, aliases: [:author] do
    confirmed_at Time.zone.now
    email
    name
    password "password"
    password_confirmation "password"
    phone
  end
end
