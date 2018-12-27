json.partial! 'api/v1/products/product', product: @product
json.pictures do
  json.array! @pictures, partial: 'api/v1/pictures/picture', as: :picture
end
json.comments do
  json.array! @comments, partial: 'api/v1/comments/comment', as: :comment
end
