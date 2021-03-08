class ChangeColName < ActiveRecord::Migration[6.0]
  def change
    rename_column :user_interests, :userId, :userid
    rename_column :user_interests, :interestId, :interestid

  end
end
