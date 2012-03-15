require "demo/helper"

module Demo
  module Model
    module Util
      class TestAttributeAssigner < TestCase
        def setup
          klass = Struct.new(:a,:b) { include AttributeAssigner }
          @object = klass.new
        end

        def test_update_attributes
          @object.update_attributes(:a, { :a => 1, :b => 2 })

          assert_equal 1, @object.a, "attr a should be written to"
          assert_nil      @object.b, "attr b should not be written to"
        end

        def test_update_attributes_raises_if_no_attributes_provided
          assert_raises ArgumentError do
            @object.update_attributes({ :x => 1 })
          end

          assert_raises ArgumentError do
            @object.update_attributes(nil, nil, { :x => 1 })
          end
        end
      end
    end
  end
end
