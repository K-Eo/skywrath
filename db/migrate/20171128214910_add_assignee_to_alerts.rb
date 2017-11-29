class AddAssigneeToAlerts < ActiveRecord::Migration[5.1]
  def change
    add_reference :alerts, :assignee, foreign_key: { to_table: :users }
  end
end
