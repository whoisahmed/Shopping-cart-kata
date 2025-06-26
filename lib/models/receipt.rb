class Receipt

  def initialize
    @items = []
    @discounts = []
  end

  attr_reader :items, :discounts

  def total_price
    total = 0.0
    for item in @items do
      total += item.total_price
    end
    for discount in @discounts do
      total -= discount.discount_amount
    end
    total
  end

  def add_product(product, quantity, price)
    @items << ReceiptItem.new(product, quantity, price)
    nil
  end

  def add_discount(discount)
    @discounts << discount
    nil
  end

end
