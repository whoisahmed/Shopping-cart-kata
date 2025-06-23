require_relative '../../lib/models/shopping_cart'
require_relative '../../lib/models/product_quantity'

describe ShoppingCart do
  subject(:shopping_cart) { described_class.new }

  describe "#add_item" do
    it "adds item to shopping cart" do
      shopping_cart.add_item("Apple")

      expect(shopping_cart.items.count).to eq 1
    end
  end

  describe "#add_item_quantity" do
    it "adds item with specified quantity to shopping cart" do
      shopping_cart.add_item_quantity("Apple", 2)

      expect(shopping_cart.product_quantities["Apple"]).to eq 2
    end
  end
end