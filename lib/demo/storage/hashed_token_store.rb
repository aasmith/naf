module Demo
  module Storage
    # Transiently stores tokens for the duration of the instance.
    # Useful for testing.
    class HashedTokenStore
      def initialize
        @store = {}
      end

      def add(token, value)
        @store[token] = value
      end

      # Returns user id belonging to token.
      def verify(token)
        @store[token] or
        raise Errors::AuthorizationFailure, "token invalid or expired"
      end

      def all
        @store.dup
      end
    end
  end
end
