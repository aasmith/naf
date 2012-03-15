module Demo
  module Model
    # A base class for providing common functionality for
    # business domain classes.
    class Model
      include ActiveModel::Validations

      extend  Util::AttributeAccessor::ClassMethods
      include Util::AttributeAccessor::InstanceMethods

      include Util::AttributeAssigner

      attributes :id

      def ==(other)
        other.id == id
      end
    end
  end
end
