class Alert < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: "author_id"

  scope :newest, -> { order(created_at: "DESC", id: "DESC") }
end
