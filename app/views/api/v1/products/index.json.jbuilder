json.partial! 'common/page', resources: @products
json.products do
  json.array! @products, partial: 'api/v1/products/product', as: :product
end
