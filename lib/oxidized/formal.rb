module Oxidized
  class Formal
    SIMPLE_ACCESSOR = %i[
      manufacturer
      name
      firmware_version
      cores
      ram
      nvmem
    ].freeze

    # create reader and writer method for simple accessors
    SIMPLE_ACCESSOR.each do |method|
      define_method(method.to_s) do
        instance_variable_get("@#{method}")
      end
      define_method(method.to_s + "=") do |value|
        instance_variable_set("@#{method}", value)
      end
    end

    # return hash with simple accessor name as string and instance variable value as value
    def to_h
      SIMPLE_ACCESSOR.map do |key|
        [key.to_s, instance_variable_get("@#{key}")]
      end.to_h
    end
  end
end
