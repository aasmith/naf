require "demo/helper"

module Demo
  module Service
    class TestProductService < TestCase
      include Model
      include Storage
      include Logging

      def test_create_product_by_admin
        boss = User.new
        boss.level = User::Administrator

        widget = Product.new
        widget.name = "Widget"

        service = ProductService.new
        service.dao = MemoryDao.new :binder => Product
        service.log = Logger.new

        service.create_product(boss, widget)

        found_product = service.find_product(boss, :name => "Widget")

        assert_equal widget, found_product
      end

      def test_create_product_by_user
        bob = User.new
        product = Product.new

        service = ProductService.new

        assert_raises Errors::NoPermissionError do
          service.create_product(bob, product)
        end

        # TODO assert no product created
      end
    end
  end
end
