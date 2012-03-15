require "demo/helper"

module Demo
  module Service
    module Util
      class TestAuthorization < TestCase
        class Secret
          include Authorization

          def initialize
            @token = nil
          end

          # A method for inserting tokens for testing only.
          def accept(token, user)
            @token = token
            @user = user
          end

          # A rigged token to user resolver.
          def resolve_token(token)
            return @user if token == @token
          end

          def classified(user_or_token)
            require_admin(user_or_token)
            true
          end

          def unclassified(user_or_token)
            require_user(user_or_token)
            true
          end
        end

        class User
          def level
            Authorization::Regular
          end
        end

        class Admin
          def level
            Authorization::Administrator
          end
        end

        def setup
          @secret = Secret.new
          @user = User.new
          @admin = Admin.new

          @admin_token = "admtok"
          @user_token = "regtok"
        end

        def test_require_auth_with_regular_user
          assert_raises Errors::NoPermissionError do
            @secret.classified(@user)
          end

          assert @secret.unclassified(@user)
        end

        def test_require_auth_with_admin_user
          assert @secret.classified(@admin)
          assert @secret.unclassified(@admin)
        end

        def test_require_auth_with_user_token
          @secret.accept @user_token, @user

          assert_raises Errors::NoPermissionError do
            @secret.classified(@user_token)
          end

          assert @secret.unclassified(@user_token)
        end

        def test_require_auth_with_admin_token
          @secret.accept @admin_token, @admin

          assert @secret.classified(@admin_token)
          assert @secret.unclassified(@admin_token)
        end

        def test_require_auth_with_bad_token
          assert_raises Errors::AuthorizationFailure do
            @secret.classified("not a valid token")
          end

          assert_raises Errors::AuthorizationFailure do
            @secret.unclassified("not a valid token")
          end
        end

        def test_require_auth_with_incorrect_object
          assert_raises ArgumentError do
            @secret.classified(Object.new)
          end

          assert_raises ArgumentError do
            @secret.unclassified(Object.new)
          end
        end
      end
    end
  end
end
