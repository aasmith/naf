require "demo/helper"

module Demo
  module Model
    module Util
      class TestAttributeAccessor < TestCase
        class Foo
          extend AttributeAccessor::ClassMethods
          include AttributeAccessor::InstanceMethods

          attributes :a, :b
        end

        class SubFoo < Foo
          attributes :c
        end

        def test_accessors
          object = Foo.new

          assert_equal 1, object.a = 1
        end

        def test_instance_attributes
          object = Foo.new
          object.a = 1

          assert_equal({:a => 1, :b => nil}, object.attributes)
        end

        def test_attributes_are_inherited_and_additive
          assert_equal [:a,:b,:c], SubFoo.new.attributes.keys
        end
      end
    end
  end
end
