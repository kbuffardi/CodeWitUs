class CreateAlertMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :alert_messages do |t|
      t.string :message
      t.integer :user
      t.datetime :expiry

      t.timestamps
    end
  end
end
