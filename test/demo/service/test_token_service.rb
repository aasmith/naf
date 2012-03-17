require "demo/helper"

module Demo
  module Service
    class TestTokenService < TestCase
      def test_auth_fail
        dao = Class.new do
          def find(*args); false; end
        end.new

        service = TokenService.new
        service.dao = dao

        assert_raises Errors::AuthorizationFailure do
          service.authorize("bob", "anything")
        end
      end

      def test_auth_success
        dao = Class.new do
          def find(*args)
            u = Model::User.new
            u.id = 1
            u.name = "bob"
            u
          end
        end.new

        service = TokenService.new
        service.token_store = Storage::HashedTokenStore.new
        service.dao = dao

        token = service.authorize("bob", "anything")

        assert token, "A token should be returned"
      end
    end
  end
end
