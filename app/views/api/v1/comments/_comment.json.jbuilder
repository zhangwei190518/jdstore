json.extract! comment, :id, :body, :created_at, :updated_at
json.user do
  json.partial! 'api/v1/users/user', user: comment.user
end
