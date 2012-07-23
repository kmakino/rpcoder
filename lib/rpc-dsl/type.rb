
require './lib/rpc-dsl/property'

module RpcDsl
  class Type
    def initialize(name, &block)
      @name = name
      @description = ""
      @fields = []
      self.instance_eval(&block)
    end

    attr_reader :name, :description, :fields
      
    def field(name, type, options = {})
      @fields << Property.new(name, type, options)
    end
  end
end

