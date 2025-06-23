require_relative '../spec_helper'

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

  describe '#handle_offers' do
    let(:receipt) { double("Receipt") }
    let(:catalog) { double("Catalog") }

    context "when two for amount offer is applied" do
      let(:offers) { { "Apple" => double("Offer", offer_type: SpecialOfferType::TWO_FOR_AMOUNT, argument: 3.0) } }

      before do
        allow(catalog).to receive(:unit_price).and_return(2.0)
        shopping_cart.add_item_quantity("Apple", 4)
      end

      it "applies offers correctly" do
        expect(receipt).to receive(:add_discount) do |discount|
          expect(discount).to be_a(Discount)
          expect(discount.product).to eq("Apple")
          expect(discount.description).to eq("2 for 3.0")
          expect(discount.discount_amount).to eq(2.0)
        end

        shopping_cart.handle_offers(receipt, offers, catalog)
      end
    end


    context "when three for two offer is applied" do
      let(:offers) { { "Banana" => double("Offer", offer_type: SpecialOfferType::THREE_FOR_TWO) } }

      before do
        allow(catalog).to receive(:unit_price).and_return(1.0)
        shopping_cart.add_item_quantity("Banana", 5)
      end

      it "applies offers correctly" do
        expect(receipt).to receive(:add_discount) do |discount|
          expect(discount).to be_a(Discount)
          expect(discount.product).to eq("Banana")
          expect(discount.description).to eq("3 for 2")
          expect(discount.discount_amount).to eq(1.0)
        end

        shopping_cart.handle_offers(receipt, offers, catalog)
      end
    end

    context "when five for amount offer is applied" do
      let(:offers) { { "Orange" => double("Offer", offer_type: SpecialOfferType::FIVE_FOR_AMOUNT, argument: 4.0) } }

      before do
        allow(catalog).to receive(:unit_price).and_return(1.0)
        shopping_cart.add_item_quantity("Orange", 6)
      end

      it "applies offers correctly" do
        expect(receipt).to receive(:add_discount) do |discount|
          expect(discount).to be_a(Discount)
          expect(discount.product).to eq("Orange")
          expect(discount.description).to eq("5 for 4.0")
          expect(discount.discount_amount).to eq(1.0)
        end

        shopping_cart.handle_offers(receipt, offers, catalog)
      end
    end


    context "when ten percent discount offer is applied" do
      let(:offers) { { "Grapes" => double("Offer", offer_type: SpecialOfferType::TEN_PERCENT_DISCOUNT, argument: 10) } }

      before do
        allow(catalog).to receive(:unit_price).and_return(2.0)
        shopping_cart.add_item_quantity("Grapes", 3)
      end

      it "applies offers correctly" do
        expect(receipt).to receive(:add_discount) do |discount|
          expect(discount).to be_a(Discount)
          expect(discount.product).to eq("Grapes")
          expect(discount.description).to eq("10% off")
          expect(discount.discount_amount).to eq(0.6)
        end

        shopping_cart.handle_offers(receipt, offers, catalog)
      end
    end
   
  end
end