
require File.dirname(__FILE__) + "/property"

module RpcDsl
  class Function
    PARAMS_IN_URL_RE = /:[\w\d]+/

    def initialize(name, &block)
      @name = name
      @params = []
      @responses = []
      self.instance_eval(&block)
    end

    attr_reader :name, :params, :responses

    def method(str)
      @method = str
    end

    def get_method
      @method
    end

    def path(str)
      @path = str
    end

    def get_path
      @path
    end

    def description(str)
      @description = str
    end

    def get_description
      @description
    end

    def param(name, type, options = {})
      @params << Property.new(name, type, options)
    end

    def response(name, type, options = {})
      @responses << Property.new(name, type, options)
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

    def has_responses?
      !@responses.empty?
    end
  end
end

