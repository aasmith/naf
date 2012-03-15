module Demo
  module Service
    # A basic service that provides authorization against tokens and users.
    class Service
      include Util::Authorization

      class_attribute :dao

      class_attribute :token_store, :authorization_dao

      def resolve_token(token)
        id  = token_store.verify(token)
        obj = authorization_dao.find(:id => id)

        return obj
      end
    end
  end
end
