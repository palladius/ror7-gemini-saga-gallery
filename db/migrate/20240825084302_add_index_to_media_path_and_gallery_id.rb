class AddIndexToMediaPathAndGalleryId < ActiveRecord::Migration[7.2]
  def change
    add_index :media, [:path, :gallery_id], unique: true
  end
end
