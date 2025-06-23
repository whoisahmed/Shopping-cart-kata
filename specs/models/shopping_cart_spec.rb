let(:catalog) { double("Catalog", unit_price: ->(product) { 2.0 }) }

describe ShoppingCart do
  describe '#handle_offers' do
    it 'applies offers correctly' do
      cart = ShoppingCart.new
      product = double("Product")
      quantity_as_int = 5
      x = 2
      offer = double("Offer", argument: 1)

      total = offer.argument * (quantity_as_int / x) + quantity_as_int % 2 * catalog.unit_price(product)
      expect(total).to eq(6.0)
    end
  end
end