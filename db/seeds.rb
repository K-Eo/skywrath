# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


users = [
  ["David Eyre", "david@skywrath.com", "8772193", 17.262889, -97.6831033],
  ["Mia Volkova", "mia@skywrath.com", "2048666", 17.2743233, -97.6897572],
  ["Sherri Jones", "sherri@skywrath.com", "9692707", 17.268371, -97.6765177],
  ["Tom Hamada", "tom@skywrath.com", "8503886", 17.271895, -97.6781167]
]

users.each do |name, email, phone, lat, lng|
  user = User.create!(email: email,
                      lat: lat,
                      lng: lng,
                      name: name,
                      password: "password",
                      phone: phone)
  user.confirm
end
