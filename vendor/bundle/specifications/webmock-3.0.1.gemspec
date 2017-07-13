# -*- encoding: utf-8 -*-
# stub: webmock 3.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "webmock"
  s.version = "3.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Bartosz Blimke"]
  s.date = "2017-04-12"
  s.description = "WebMock allows stubbing HTTP requests and setting expectations on HTTP requests."
  s.email = ["bartosz.blimke@gmail.com"]
  s.homepage = "http://github.com/bblimke/webmock"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0")
  s.rubyforge_project = "webmock"
  s.rubygems_version = "2.4.5.1"
  s.summary = "Library for stubbing HTTP requests in Ruby."

  s.installed_by_version = "2.4.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<addressable>, [">= 2.3.6"])
      s.add_runtime_dependency(%q<crack>, [">= 0.3.2"])
      s.add_runtime_dependency(%q<hashdiff>, [">= 0"])
      s.add_development_dependency(%q<patron>, [">= 0.4.18"])
      s.add_development_dependency(%q<curb>, [">= 0.7.16"])
      s.add_development_dependency(%q<typhoeus>, [">= 0.5.0"])
      s.add_development_dependency(%q<http>, [">= 0.8.0"])
      s.add_development_dependency(%q<rack>, ["= 1.6.0"])
      s.add_development_dependency(%q<rspec>, [">= 3.1.0"])
      s.add_development_dependency(%q<httpclient>, [">= 2.2.4"])
      s.add_development_dependency(%q<em-http-request>, [">= 1.0.2"])
      s.add_development_dependency(%q<em-synchrony>, [">= 1.0.0"])
      s.add_development_dependency(%q<excon>, [">= 0.27.5"])
      s.add_development_dependency(%q<minitest>, [">= 5.0.0"])
      s.add_development_dependency(%q<test-unit>, [">= 3.0.0"])
      s.add_development_dependency(%q<rdoc>, ["> 3.5.0"])
    else
      s.add_dependency(%q<addressable>, [">= 2.3.6"])
      s.add_dependency(%q<crack>, [">= 0.3.2"])
      s.add_dependency(%q<hashdiff>, [">= 0"])
      s.add_dependency(%q<patron>, [">= 0.4.18"])
      s.add_dependency(%q<curb>, [">= 0.7.16"])
      s.add_dependency(%q<typhoeus>, [">= 0.5.0"])
      s.add_dependency(%q<http>, [">= 0.8.0"])
      s.add_dependency(%q<rack>, ["= 1.6.0"])
      s.add_dependency(%q<rspec>, [">= 3.1.0"])
      s.add_dependency(%q<httpclient>, [">= 2.2.4"])
      s.add_dependency(%q<em-http-request>, [">= 1.0.2"])
      s.add_dependency(%q<em-synchrony>, [">= 1.0.0"])
      s.add_dependency(%q<excon>, [">= 0.27.5"])
      s.add_dependency(%q<minitest>, [">= 5.0.0"])
      s.add_dependency(%q<test-unit>, [">= 3.0.0"])
      s.add_dependency(%q<rdoc>, ["> 3.5.0"])
    end
  else
    s.add_dependency(%q<addressable>, [">= 2.3.6"])
    s.add_dependency(%q<crack>, [">= 0.3.2"])
    s.add_dependency(%q<hashdiff>, [">= 0"])
    s.add_dependency(%q<patron>, [">= 0.4.18"])
    s.add_dependency(%q<curb>, [">= 0.7.16"])
    s.add_dependency(%q<typhoeus>, [">= 0.5.0"])
    s.add_dependency(%q<http>, [">= 0.8.0"])
    s.add_dependency(%q<rack>, ["= 1.6.0"])
    s.add_dependency(%q<rspec>, [">= 3.1.0"])
    s.add_dependency(%q<httpclient>, [">= 2.2.4"])
    s.add_dependency(%q<em-http-request>, [">= 1.0.2"])
    s.add_dependency(%q<em-synchrony>, [">= 1.0.0"])
    s.add_dependency(%q<excon>, [">= 0.27.5"])
    s.add_dependency(%q<minitest>, [">= 5.0.0"])
    s.add_dependency(%q<test-unit>, [">= 3.0.0"])
    s.add_dependency(%q<rdoc>, ["> 3.5.0"])
  end
end
