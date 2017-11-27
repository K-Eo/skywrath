class AddClosedByToAlerts < ActiveRecord::Migration[5.1]
  def change
    add_reference :alerts, :closed_by, foreign_key: { to_table: :users }
  end
end
