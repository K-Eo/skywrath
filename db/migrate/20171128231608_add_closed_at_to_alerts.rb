class AddClosedAtToAlerts < ActiveRecord::Migration[5.1]
  def change
    add_column :alerts, :closed_at, :datetime
  end
end
