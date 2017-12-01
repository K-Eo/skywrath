class AddStateToAlerts < ActiveRecord::Migration[5.1]
  def change
    add_column :alerts, :state, :string
    add_index :alerts, :state
  end
end
