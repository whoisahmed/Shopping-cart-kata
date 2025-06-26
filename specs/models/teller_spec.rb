require_relative '../spec_helper'

describe Teller do
  let(:catalog) { double("Catalog") }
  subject(:teller) { described_class.new(catalog) }

  describe "#add_special_offer" do
    it "adds special offer" do
      teller.add_special_offer(
                    offer_type: SpecialOfferType::THREE_FOR_TWO,
                    product: "Apple",
                    argument: 2)
      expect(teller.offers.count).to eq 1
    end
  end


  describe "#checks_out_articles_from" do
    before do
      allow(catalog).to receive(:unit_price).with("Apple").and_return(1.0)
      allow(catalog).to receive(:unit_price).with("Banana").and_return(0.5)
    end

    it "checks out articles from the shopping cart" do
      shopping_cart = ShoppingCart.new
      shopping_cart.add_item_quantity("Apple", 3)
      shopping_cart.add_item_quantity("Banana", 4)
      teller.add_special_offer(offer_type: SpecialOfferType::TWO_FOR_AMOUNT,
                                product: "Banana",  
                                argument: 2)

      receipt = teller.checks_out_articles_from(shopping_cart)

      expect(receipt).to be_a(Receipt)
      expect(receipt.items.count).to eq 2
      expect(receipt.discounts.count).to eq 1
    end
  end
 
  
end