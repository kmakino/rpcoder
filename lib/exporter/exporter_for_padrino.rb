# encoding: utf-8

require 'fileutils'
require File.dirname(__FILE__) + "/exporter"

module Exporter4Padrino
  extend Exporter

  @@padrino_routing_templates = [ "routes" ]
  @@padrino_api_templates = [ "request", "response", "validator" ]
  @@padrino_type_templates = [ "type" ]
  @@padrino_misc_templates = [ "api", "rpc_validation_exception" ]

  def application_name(name)
    @application_name = name
  end

  def get_application_name
    @application_name
  end

  def generate_ruby_code(output_dir)
    controller_dir = File.join(output_dir, 'app/controllers/api')
    model_dir = File.join(output_dir, 'models/api')

    FileUtils.mkdir_p(controller_dir)
    FileUtils.mkdir_p(model_dir)

    language = 'padrino'
    ext = '.rb'
      
    # generate routing.
    routes = Hash.new
    rpcs.each do |func|
      func.path_parts.first.match(/\/[a-zA-Z]+/) do |root_path|
        if routes[root_path.to_s].nil?
          routes[root_path.to_s] = Array.new
        end
        routes[root_path.to_s].push func
      end
    end
    @@padrino_routing_templates.each do |template|
      routes.each do |route, funcs|
        output_path = get_export_filepath(controller_dir, route.to_s.delete('/'), ext)
        puts "Route: #{output_path}"
        render_erb(output_path, make_template_path(language, template), binding)
      end
    end

    # generate request, response and validator.
    rpcs.each do |func|
      @@padrino_api_templates.each do |template|
        output_path = get_export_filepath(model_dir, func.name.downcase + '_' + template, ext)
        puts "API: #{output_path}"
        render_erb(output_path, make_template_path(language, template), binding)
      end
    end

      
    # generate original types.
    @@padrino_type_templates.each do |template|
      types.each do |type|
        filename = type.name.to_camelcase(false)
              
        output_path = get_export_filepath(model_dir, filename, ext)
        puts "Type: #{output_path}"
        render_erb(output_path, make_template_path(language, template), binding)
      end
    end

    # generate misc.
    @@padrino_misc_templates.each do |template|
      output_path = get_export_filepath(model_dir, template, ext)
      puts "MISC: #{output_path}"
      render_erb(output_path, make_template_path(language, template), binding)
    end
  end
end

