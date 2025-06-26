ReceiptItem = Struct.new(:product, :quantity, :price) do

  undef :product=, :quantity=, :price=

  def total_price
    quantity * price
  end
end
