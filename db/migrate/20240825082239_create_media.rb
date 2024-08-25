class CreateMedia < ActiveRecord::Migration[7.2]
  def change
    create_table :media do |t|
      t.string :title
      t.string :path
      t.text :caption
      t.string :media_type
      t.integer :gallery_id
      t.float :gemini_relevance
      t.float :gemini_quality
      t.text :gemini_description
      t.text :gemini_text
      t.integer :file_size
      t.string :dimensions
      t.string :original_filename
      t.integer :user_id
      t.boolean :public, default: true

      t.timestamps
    end
  end
end
