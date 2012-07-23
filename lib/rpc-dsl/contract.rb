
require './lib/rpc-dsl/constant'
require './lib/rpc-dsl/error_code'
require './lib/rpc-dsl/type'
require './lib/rpc-dsl/function'

module RpcDsl
  class Contract
    def initialize(name, &block)
      @contract_name = name
      @namespace = ""
      @constants = []
      @error_codes = []
      @types = []
      @functions = []
      self.instance_eval(&block)
    end

    attr_accessor :contract_name, :namespace, :constants, :error_codes, :types, :functions
  end
end

