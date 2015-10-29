json.array!(@colleges) do |college|
  json.extract! college, :id, :name, :address
  json.url college_url(college, format: :json)
end
