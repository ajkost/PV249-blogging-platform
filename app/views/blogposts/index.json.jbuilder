json.array!(@blogposts) do |blogpost|
  json.extract! blogpost, :id, :author, :body
  json.url blogpost_url(blogpost, format: :json)
end
