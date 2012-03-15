require "demo/helper"

module Demo
  module Model
    class TestLineItem < TestCase
      def test_line_item_price
        bolt = Product.new
        bolt.price = 20

        line = LineItem.new
        line.product = bolt
        line.qty = 5

        assert_equal line.price, 100
      end
    end
  end
end
