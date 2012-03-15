module Demo
  module Model
    class User < Model
      Regular = "REG"
      Administrator = "ADM"

      attributes :name, :level, :email, :password

      def admin?
        level == Administrator
      end

      def regular?
        level == Regular
      end
    end
  end
end
