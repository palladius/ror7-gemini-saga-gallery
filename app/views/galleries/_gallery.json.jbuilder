json.extract! gallery, :id, :title, :description, :public, :cover_image_id, :user_id, :created_at, :updated_at
json.url gallery_url(gallery, format: :json)
