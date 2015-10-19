json.array!(@users) do |user|
  json.extract! user, :id, :name, :email, :activation_digest, :remember_digest, :admin, :activated_at, :reset_digest, :reset_sent_at
  json.url user_url(user, format: :json)
end
