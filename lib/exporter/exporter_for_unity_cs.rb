
require 'fileutils'
require File.dirname(__FILE__) + "/exporter"

module Exporter4UnityCS
  include Exporter

  @@unity_cs_api_templates = [ "API", "Interface", "Dummy", "DummyServer", "APIExtensions" ]
  @@unity_cs_type_templates = { :basic => "Type", :JSON => "TypeJSON" }

  def generate_cs_code(output_dir)
    FileUtils.mkdir_p(output_dir)

    language = 'unity_cs'
    ext = '.cs'

    # generate API classes.
    @@unity_cs_api_templates.map {|name|
        bind_name_and_path(name, language)
    }.each do |api_template_pair|
      output_path = get_export_filepath(output_dir, contract_name + api_template_pair[:template_name], ext)
          puts "API: #{output_path}"
      render_erb(output_path, api_template_pair[:template_path], binding)
    end
      
    # generate original types.
    @@unity_cs_type_templates.each do |key, value|
      types.each do |type|
        if key == :basic
          filename = type.name
        else
          filename = type.name + key.id2name
        end
        
        output_path = get_export_filepath(output_dir, filename, ext)
        puts "Type: #{output_path}"
        render_erb(output_path, make_template_path(language, value), binding)
      end
    end
  end
end

