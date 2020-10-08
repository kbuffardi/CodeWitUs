class CreateVideos < ActiveRecord::Migration[6.0]
  def change
    create_table :videos do |t|
      t.string :user
      t.string :video_id

      t.timestamps
    end
  end
end
