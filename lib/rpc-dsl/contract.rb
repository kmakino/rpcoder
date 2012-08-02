
require 'fileutils'
current_dir = File.dirname(__FILE__)
require current_dir + "/constant"
require current_dir + "/type"
require current_dir + "/function"

module RpcDsl
  module Contract
    @@constants = []
    @@types = []
    @@rpcs = []

    def self.initialize(&block)
      self.instance_eval(&block)
    end

    def self.name(str)
      @@name = str
    end

    def self.contract_name
      @@name
    end

    def self.namespace(str)
      @@namespace = str
    end

    def self.get_namespace
      @@namespace
    end

    def self.get_namespace_dir(root_dir)
      File.join(root_dir, @@namespace.split('.'))
    end

    def self.description(str)
      @@description = str
    end

    def self.get_description
      @@description
    end

    def self.version(v)
      @@version = v
    end

    def self.get_version
      @@version
    end

    def self.constants
      @@constants
    end

    def self.constant(name, value)
      constants << Constant.new(name, 12)
    end

    def self.types
      @@types
    end

    def self.type(name, &block)
      types << Type.new(name, &block)
    end

    def self.rpcs
      @@rpcs
    end

    def self.rpc(name, &block)
      rpcs << Function.new(name, &block)
    end
  end
end

