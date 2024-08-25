class CreateGalleries < ActiveRecord::Migration[7.2]
  def change
    create_table :galleries do |t|
      t.string :title
      t.text :description
      t.boolean :public
      t.integer :cover_image_id
      t.integer :user_id

      t.timestamps
    end
  end
end
