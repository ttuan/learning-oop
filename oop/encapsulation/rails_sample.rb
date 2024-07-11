# 1. Encapsulation in models
class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items

  # Public method
  def total_price
    order_items.sum(&:price)
  end

  # Encapsulate the calculation logic in a private method
  private

  def calculate_total
    self.total = total_price
  end
end


# 2. Protect sensitive attributes
class User < ApplicationRecord
  has_secure_password

  # Only expose necessary public methods
  def authenticate(password)
    self.authenticate_password(password)
  end

  private

  # Private method to encapsulate password encryption logic
  def encrypt_password
    self.password_digest = BCrypt::Password.create(password)
  end
end

# 3. Modularity and separation of concerns
class CreateOrderService
  def initialize(user, order_params)
    @user = user
    @order_params = order_params
  end

  def call
    create_order
  end

  private

  def create_order
    order = Order.new(@order_params)
    order.user = @user
    order.save
    order
  end
end

# 4. Easy to testing and debugging
class Product < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }

  # Encapsulate complex validation logic
  validate :validate_price_with_discount

  private

  def validate_price_with_discount
    if discount.present? && price <= discount
      errors.add(:price, "must be greater than the discount")
    end
  end
end

