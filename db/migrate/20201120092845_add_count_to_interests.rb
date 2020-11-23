class AddCountToInterests < ActiveRecord::Migration[6.0]
  def change
    add_column :interests, :interest_count, :integer, :default => 0
  end
end
