class CreateAlerts < ActiveRecord::Migration[5.1]
  def change
    create_table :alerts do |t|
      t.references :author, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
