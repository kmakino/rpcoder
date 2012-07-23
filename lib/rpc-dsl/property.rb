
module RpcDsl
  class Property
    def self.original_types
      [:int, :Int, :double, :Double, :string, :String, :bool, :Boolean, :Array]
    end

    attr_accessor :name, :type, :options
    def initialize(name, type, options = {})
      @name = name
      @type = type
      @options = options
    end

    def array?
      options[:array?]
    end

    def optional?
      options[:require] == false
    end

    def array_or_type
      if array?
         "List<#{to_c_sharp_type}>"
      else
        to_c_sharp_type
      end
    end

    def to_c_sharp_type
      case type.to_sym
      when :int, :Int
        if self.optional?
          return :int?
        else
          return :int
        end
      when :double, :Double
        if self.optional?
          return :double?
        else
          return :double
        end
      when :string, :String
        return :string
      when :bool, :Boolean
        if self.optional?
          return :bool?
        else
          return :bool
        end
      else
        return type
      end
    end

    def to_json_type?
      case type.to_sym
      when :int, :Int
        return "IsInt"
      when :double, :Double
        return "IsDouble"
      when :string, :String
        return "IsString"
      when :bool, :Boolean
        return "IsBoolean"
      else
        return type
      end
    end

    def original_type?
      Property.original_types.include?(type.to_sym)
    end

    def double?
      self.to_json_type? == "IsDouble"
    end

    def instance_creator(elem = 'elem', options = {})
      elem = element_accessor(elem, options)
      if original_type?
        elem
      else
        "new #{type}(#{elem})"
      end
    end

    def element_accessor(elem = 'elem', options = {})
      if options[:object?]
        "object['#{elem}']"
      else
        elem
      end
    end

  end
end

