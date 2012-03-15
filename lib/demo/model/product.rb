module Demo
  module Model
    class Product < Model
      attributes :sku, :name, :description, :price, :num_available

      validates_numericality_of :price, :greater_than => 0

      def in_stock?
        num_available > 0
      end
    end
  end
end
