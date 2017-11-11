Types::QueryType = GraphQL::ObjectType.define do
  name "Query"
  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  field :viewer do
    type Types::UserType
    description "Me"
    resolve -> (obj, args, ctx) {
      ctx[:current_user]
    }
  end
end
