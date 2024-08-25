class AddIndexToGalleriesTitle < ActiveRecord::Migration[7.2]
  def change
    add_index :galleries, :title, unique: true
  end
end
