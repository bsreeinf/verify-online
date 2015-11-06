json.array!(@colleges) do |college|
  json.extract! college, :id, :name, :address, :verification_amount
  json.url college_url(college, format: :json)
end
