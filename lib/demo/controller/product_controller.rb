module Demo
  module Controller
    class ProductController < ServiceController

      service Service::ProductService

      alias products service

      get '/all' do
        service.all_products.to_json
      end

      post '/new' do
        token = params[:token]
        product = params[:product]

        products.create_product(token, product)
      end
    end
  end
end
