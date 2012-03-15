module Demo
  module Model
    class LineItem < Model
       attributes :product, :order, :qty

       def price
         product.price * qty
       end
    end
  end
end
