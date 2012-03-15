module Demo
  module Model
    module Util
      module AttributeAssigner
        def update_attributes(*attributes, hash)
          if attributes.compact.empty?
            raise ArgumentError, "No attributes provided"
          end

          approved_hash = hash.select { |k,v| attributes.include? k }

          approved_hash.each do |k,v|
            send "#{k}=", v
          end
        end
      end
    end
  end
end

