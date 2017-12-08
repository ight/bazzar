class Category < ApplicationRecord

  # Associations
  has_many :items, inverse_of: :category
  has_many :brands, inverse_of: :category

  # callbacks
  after_commit :update_cat_list, on: [:create, :destroy]

  # Validations
  validates :category_name, uniqueness: true

  # Scope
  scope :active, -> { where(status: 0) }

  #Enumeration
  enum status: [:active, :disabled, :popular]

  # Module
  module Status
    ACTIVE = 'active'
    DISABLE = 'disabled'
    POPULAR = 'popular'
  end

  # callbacks defination
  def update_cat_list
    Category.list(true)
  end

  # class methods
  def self.list(reload = false)
    Rails.cache.delete(bazzar_cat_list) if reload
    Rails.cache.fetch(bazzar_cat_list, expires_in: 15.days) do
      Category.active.order(id: :desc)
    end
  end

  def self.bazzar_cat_list
    "bazzar_cat_list"
  end

  # instance method
  def disable
    update_column(:status, Category::Status::DISABLE)
  end
end