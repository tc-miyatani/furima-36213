class Item < ApplicationRecord
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :sales_status
  belongs_to :shipping_fee_status
  belongs_to :prefecture
  belongs_to :scheduled_delivery

  belongs_to :user

  with_options presence: true do
    validates :image
    validates :name
    validates :info
    validates :user
    validates :price
  end

  validates :price_before_type_cast, format: {
    with: /\A[0-9]+\z/,
    message: 'is invalid. Input half-width characters'
  }

  validates :price, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 300,
    less_than_or_equal_to: 9_999_999,
    message: 'is out of setting range'
  }

  with_options presence: true, numericality: {
    other_than: 0,
    message: "can't be blank"
  } do
    validates :category_id
    validates :sales_status_id
    validates :shipping_fee_status_id
    validates :prefecture_id
    validates :scheduled_delivery_id
  end
end
