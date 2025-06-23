require_relative '../../lib/models/receipt'
require_relative '../../lib/models/receipt_item'

describe Receipt do
  subject(:receipt) { described_class.new }

  describe "#add_product" do    
    it "adds product to receipt items" do
      receipt.add_product("Apple", 1, 2, 3)

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