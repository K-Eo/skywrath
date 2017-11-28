class Alert < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: "author_id"
  belongs_to :assignee, class_name: "User", foreign_key: "assignee_id", optional: true

  scope :newest, -> { order(created_at: "DESC", id: "DESC") }

  state_machine :state, initial: :opened do
    event :close do
      transition opened: :closed
    end

    state :opened
    state :closed

    before_transition opened: :closed do |alert|
      alert.closed_at = Time.zone.now
    end
  end
end
