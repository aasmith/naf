module Demo
  module Service
    class ProductService < Service
      attr_accessor :log

      def create_product(user_or_token, product)
        require_admin(user_or_token)

        dao.save(product)

        log.append(:created, product)
      end

      def find_product(user_or_token, values)
        require_user(user_or_token)

        dao.find(values)
      end

      def delete_product
      end

      def all_products
        [Product.new, Product.new]
      end
    end
  end
end
