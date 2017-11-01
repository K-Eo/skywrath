FactoryBot.define do
  sequence :email do |n|
    "bot_#{n}@skywrath.com"
  end

  sequence :name do |n|
    "Bot #{n}"
  end

  sequence :phone do |n|
    "321444567#{n}"
  end
end
