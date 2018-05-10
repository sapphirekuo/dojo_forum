json.data do
  json.array! @posts do |post|
    json.(post, :id, :title, :description)
  end
end