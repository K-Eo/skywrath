class AddAssistingAtToAlerts < ActiveRecord::Migration[5.1]
  def change
    add_column :alerts, :assisting_at, :datetime
  end
end
