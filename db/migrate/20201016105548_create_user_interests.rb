class CreateUserInterests < ActiveRecord::Migration[6.0]
  def change
    create_table :user_interests do |t|
      t.integer :userId
      t.integer :interestid

      t.timestamps
    end
  end
end
