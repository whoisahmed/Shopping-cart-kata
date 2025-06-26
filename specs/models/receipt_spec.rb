require_relative '../spec_helper'


describe Receipt do
  subject(:receipt) { described_class.new }

  describe "#total_price" do
    it "returns total price of receipt items" do
      receipt.add_product("Apple", 1, 2)
      receipt.add_product("Banana", 2, 1)

      expect(receipt.total_price).to eq 4.0
    end

    it "returns zero when no items are present" do
      expect(receipt.total_price).to eq 0.0
    end

    it "accounts for discounts" do
      receipt.add_product("Apple", 1, 2)
      receipt.add_product("Banana", 2, 1)

      discount = Struct.new(:discount_amount)
      receipt.add_discount(discount.new(2.0))

      expect(receipt.total_price).to eq 2.0
    end
  end

  describe "#add_product" do    
    it "adds product to receipt items" do
      receipt.add_product("Apple", 1, 2)

      expect(receipt.items.count).to eq 1
    end
  end

  describe "#add_discount" do
    it "adds discount to receipt" do
      discount = Struct.new(:discount_amount)

      receipt.add_discount(discount)

      expect(receipt.discounts.count).to eq 1
    end
  end
end