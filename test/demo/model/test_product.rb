require "demo/helper"

module Demo
  module Model
    class TestProduct < TestCase
      def test_product_in_stock?
        widget = Product.new
        widget.num_available = 1

        assert widget.in_stock?

        widget.num_available = 0

        refute widget.in_stock?
      end

      def test_product_valid_price
        widget = Product.new

        widget.valid?
        refute widget.errors[:price].empty?, "Should have an error"

        widget.price = 1
        widget.valid?
        assert widget.errors[:price].empty?, "Should have no errors"

        widget.price = 0
        widget.valid?
        refute widget.errors[:price].empty?, "Should have an error"
      end
    end
  end
end
