module Demo
  module Service
    class TokenService < Service
      def authorize(u,p)
        user = dao.find(:name => u, :password => p)

        if user
          token = generate_token
          token_store.add(token, user.id)
          log_auth_event
        else
          log_auth_fail
          raise Errors::AuthorizationFailure, "Not authorized"
        end

        return token
      end

      def generate_token
        SecureRandom.uuid
      end

      def log_auth_event
      end

      def log_auth_fail
      end

      def all(user_or_token)
        require_admin(user_or_token)

        token_store.all
      end
    end
  end
end
