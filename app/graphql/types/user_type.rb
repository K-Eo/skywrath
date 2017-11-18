Types::UserType = GraphQL::ObjectType.define do
  name "User"
  description "A simple user"

  field :id, types.Int
  field :name, types.String
  field :email, types.String
  field :created_at, types.String
  field :updated_at, types.String
  field :avatar do
    type types.String
    argument :size, types.Int, default_value: 80
    resolve -> (obj, args, ctx) {
      size = args[:size]

      hash = Digest::MD5.hexdigest(obj.email)
      "https://www.gravatar.com/avatar/#{hash}?s=#{size}&d=retro"
    }
  end
end
