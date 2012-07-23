
require './lib/rpc-dsl/property'

module RpcDsl
  class Function
    PARAMS_IN_URL_RE = /:[\w\d]+/

    def initialize(name, &block)
      @name = name
      @path = ""
      @method = :GET
      @description = ""
      @params = []
      @response_params = []
      self.instance_eval(&block)
    end

    attr_reader :name, :description, :params, :response_params

    def add_param(name, type, options = {})
      @params << Property.new(name, type, options)
    end

    def add_response_param(name, type, options = {})
      @response_params << Property.new(name, type, options)
    end

    def path_parts
      raise "path must starts with `/`: #{@path}" unless @path =~ /^\//
        
      path_strs = @path.split(PARAMS_IN_URL_RE)
      params = @path.scan(PARAMS_IN_URL_RE)
      parts = []
      ([path_strs.size, params.size].max).times do |variable|
        parts << %Q{"#{path_strs.shift}"}
        parts << params.shift.sub(/^:/, '') rescue nil
      end
      parts
    end

    def query_params
      param_strs = @path.scan(PARAMS_IN_URL_RE).map { |i| i.sub(/^:/, '') }
      @params.select { |i| !param_strs.include?(i.name.to_s)  }
    end
      
    def has_query_params?
      !query_params.empty?
    end
      
    def is_get?
        true if @method == :GET
    end

    def has_response_params?
      !@response_params.empty?
    end
  end
end

