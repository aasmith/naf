module Demo
  module Model
    module Util
      # Consider including ActiveModel::AttributeMethods if this needs to
      # get fancier than just listing attributes on the object.
      module AttributeAccessor

        module ClassMethods
          def attributes(*attrs)
            @attributes ||= []

            attr_accessor(*attrs)
            @attributes += attrs
          end

          def inherited(child)
            child.attributes(*self.attributes)
          end
        end

        module InstanceMethods
          def attributes
            Hash[self.class.attributes.map { |a| [a, send(a)] }]
          end
        end
      end
    end
  end
end
