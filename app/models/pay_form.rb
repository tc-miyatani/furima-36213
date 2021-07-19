class PayForm
  include ActiveModel::Model
  attr_accessor :item_id, :user_id,
                :postal_code, :prefecture_id, :city,
                :addresses, :building, :phone_number,
                :token

  with_options presence: true do
    validates :token
    validates :item_id
    validates :user_id
    validates :postal_code, format: {
      with: /\A[0-9]{3}-[0-9]{4}\z/,
      message: 'is invalid. Enter it as follows (e.g. 123-4567)'
    }
    validates :prefecture_id, numericality: {
      other_than: 0,
      message: "can't be blank"
    }
    validates :city
    validates :addresses
    validates :phone_number, length: {
      in: 10..11,
      too_short: 'is too short',
      too_long: 'is too long'
    }, format: {
      with: /\A\d+\z/,
      message: 'is invalid. Input only number'
    }
  end

  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    ShippingInfo.create(
      order_id: order.id,
      postal_code: postal_code, prefecture_id: prefecture_id,
      city: city, addresses: addresses, building: building,
      phone_number: phone_number
    )
  end
end
