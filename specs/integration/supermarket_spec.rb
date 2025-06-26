require_relative '../spec_helper'

describe "Supermarket Integration" do
  let(:catalog) { FakeCatalog.new }
  let(:teller) { Teller.new(catalog) }
  let(:cart) { ShoppingCart.new }

  before do
    toothbrush = Product.new("toothbrush", ProductUnit::EACH)
    catalog.add_product(toothbrush, 0.99)

    apples = Product.new("apples", ProductUnit::KILO)
    catalog.add_product(apples, 1.99)

    cart.add_item_quantity(apples, 2.5)

    teller.add_special_offer(
      offer_type: SpecialOfferType::TEN_PERCENT_DISCOUNT,
      product: toothbrush,
      argument: 10.0)
  end

  it "applies a ten percent discount and calculates the total price" do
    receipt = teller.checks_out_articles_from(cart)
    expect(receipt.total_price).to be_within(0.01).of(4.975)
  end
end


class FakeCatalog < SupermarketCatalog

  def initialize
    @products = {}
    @prices = {}
  end

  def add_product(product, price)
    @products[product.name] = product
    @prices[product.name] = price
  end

  def unit_price(p)
    @prices.fetch(p.name)
  end

end
