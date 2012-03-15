require "demo/helper"

module Demo
  module Service
    class TestService < TestCase
      User = Struct.new(:id, :name) do
        def attributes
          { :id => id, :name => name }
        end
      end

      def setup
        @token = "usertok"
        @user  = User.new(nil, "bob")

        auth_dao = Storage::MemoryDao.new :binder => User
        auth_dao.save(@user)

        token_store = Storage::HashedTokenStore.new
        token_store.add(@token, @user.id)

        @service = Service.new
        @service.token_store = token_store
        @service.authorization_dao = auth_dao
      end

      def test_resolve_token
        assert_equal @user.id, @service.resolve_token(@token).id
      end
    end
  end
end
