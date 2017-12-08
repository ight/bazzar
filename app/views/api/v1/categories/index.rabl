object false

node :categories do
  partial 'api/v1/categories/show', object: @categories
end