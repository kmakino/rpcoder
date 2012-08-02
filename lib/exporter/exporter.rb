
require 'erb'
require File.dirname(__FILE__) + "/camelizer"

module Exporter
  @@language_dir = ["unity_cs", "padrino"]

  def template_dir(dir)
    @@template_dir = dir
  end

  def render_erb(output_path, template_path, binding)
    File.open(output_path, "w") do |file|
      file << ERB.new(File.read(template_path), nil, '-').result(binding)
    end
  end

  def bind_name_and_path(template_name, language)
    { :template_name => template_name,
      :template_path => make_template_path(language, template_name) }
  end

  def get_export_filepath(dir, name, ext)
    File.join(dir, name + ext)
  end

  def make_template_path(language, template_name)
    File.join(@@template_dir, @@language_dir.find {|l| l == language }, template_name) + '.erb'
  end
end

