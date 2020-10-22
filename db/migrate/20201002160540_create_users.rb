class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :username
      t.integer :role
      t.string :interest
      t.string :major
      t.date :dob
      t.string :gender
      t.string :password_digest
      t.string :uid
      t.string :provider

      t.timestamps
    end
  end
end
