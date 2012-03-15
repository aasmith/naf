module Demo
  module Controller
    # Plain old controller.
    class Controller < Sinatra::Base

      disable :show_exceptions

      # catch errors that the app could raise, and return the appropriate code.
      error Errors::AuthorizationFailure do
        401
      end

      error Errors::NoPermissionError do
        403
      end

      error 401 do
        "Not authorized"
      end

      error 403 do
        "Access denied"
      end

      error do
        status 500
        "Something bad happened"
      end

      not_found do
        "I dunno where I put that, bro."
      end
    end
  end
end
