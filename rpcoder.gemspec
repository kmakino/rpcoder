# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rpcoder}
  s.version = "0.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["jugyo", "Toshiyuki Hirooka"]
  s.date = %q{2011-05-11}
  s.description = %q{Simple JSON HTTP RPC generator for as3}
  s.email = %q{toshi.hirooka@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    "Gemfile",
    "Gemfile.lock",
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "lib/rpcoder.rb",
    "lib/rpcoder/function.rb",
    "lib/rpcoder/param.rb",
    "lib/rpcoder/type.rb",
    "lib/templates/API.erb",
    "lib/templates/APIDummy.erb",
    "lib/templates/APIInterface.erb",
    "lib/templates/Type.erb",
    "rpcoder.gemspec",
    "spec/fixtures/foo/bar/API.as",
    "spec/fixtures/foo/bar/APIDummy.as",
    "spec/fixtures/foo/bar/APIInterface.as",
    "spec/fixtures/foo/bar/Mail.as",
    "spec/rpcoder/function_spec.rb",
    "spec/rpcoder/param_spec.rb",
    "spec/rpcoder_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/one-up/rpcoder}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.7.2}
  s.summary = %q{Simple RPC generator for as3}
  s.test_files = [
    "spec/rpcoder/function_spec.rb",
    "spec/rpcoder/param_spec.rb",
    "spec/rpcoder_spec.rb",
    "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<sinatra>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<sinatra>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<sinatra>, [">= 0"])
  end
end

