class Alert < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: "author_id"
  belongs_to :assisted_by, class_name: "User", foreign_key: "assisted_by_id", optional: true
  belongs_to :closed_by, class_name: "User", foreign_key: "closed_by_id", optional: true

  scope :newest, -> { order(created_at: "DESC", id: "DESC") }

  state_machine :state, initial: :opened, use_transactions: true do
    event :assist do
      transition opened: :assisting
    end

    event :close do
      transition assisting: :closed
    end

    state :opened
    state :assisting
    state :closed

    before_transition opened: :assisting do |alert|
      alert.assisting_at = Time.zone.now
    end

    before_transition assisting: :closed do |alert|
      alert.closed_at = Time.zone.now
    end
  end
end
