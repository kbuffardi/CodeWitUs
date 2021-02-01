class UpdateVideos < ActiveRecord::Migration[6.0]
  def change
    add_column :videos, :vtitle, :string
    add_column :videos,  :concepts, :string
    add_column :videos,  :interests, :string
    add_column :videos,  :cwlink, :string
  end
end
