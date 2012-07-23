
module RpcDsl
  class Constant
    def initialize(name, value)
      @name, @value = name, value
    end

    attr_reader :name, :value
  end
end

