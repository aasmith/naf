module Demo
  module Controller
    class TokenController < ServiceController

      service Service::TokenService

      post '/' do
        u = params[:username]
        p = params[:password]

        token = service.authorize(u,p)

        { :token => token }.to_json
      end

      get '/all' do
        token = params[:token]

        tokens = service.all(token)

        { :tokens => tokens }.to_json
      end
    end
  end
end
