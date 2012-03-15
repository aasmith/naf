module Demo
  module Service
    module Util
      # A simple tiered-authorization layer typically for usage at a
      # service level.
      #
      # Each require_* method takes a token (String) or an object that
      # responds to level().
      #
      # Tokens are verified by calling resolve_token on the including class.
      # To disable token auth, implement:
      #
      #   def resolve_token(token)
      #     false
      #   end
      #
      # Objects returning a value from level() should return one of the
      # constants defined in the Authorization module (Administrator, Regular).
      module Authorization
        Administrator = "ADM"
        Regular       = "REG"

        def require_auth(obj_or_token, level)
          if obj_or_token.respond_to? :level
            obj = obj_or_token
          elsif String === obj_or_token
            obj = resolve_token(obj_or_token) or
              raise Errors::AuthorizationFailure, "bad token"
          else
            raise ArgumentError,
              "#{obj_or_token.inspect} not a token or doesnt respond to level()"
          end

          success = case level
            when Regular       then [Regular, Administrator].include? obj.level
            when Administrator then obj.level == Administrator
          end

          success or
            raise Errors::NoPermissionError, "user does not have permission"
        end

        def require_admin(obj_or_token)
          require_auth(obj_or_token, Administrator)
        end

        def require_user(obj_or_token)
          require_auth(obj_or_token, Regular)
        end

        def require_none
        end

        def resolve_token(token)
          raise NotImplementedError, "implement in the including class"
        end
      end
    end
  end
end
