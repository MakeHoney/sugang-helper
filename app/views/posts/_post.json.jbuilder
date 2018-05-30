json.extract! post, :id, :title, :category_id, :desc1, :desc2, :created_at, :updated_at
json.url post_url(post, format: :json)
