module Demo
  module Model
    class Order < Model
      attributes :line_items

      validates_presence_of :line_items

      def tax
      end

      def shipping
      end

      def subtotal
        line_items.map(&:price).reduce(:+)
      end

      def total
        subtotal + tax + shipping
      end
    end
  end
end
