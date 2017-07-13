# -*- encoding: utf-8 -*-
# stub: multi_xml 0.6.0 ruby lib

Gem::Specification.new do |s|
  s.name = "multi_xml"
  s.version = "0.6.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.5") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Erik Michaels-Ober"]
  s.date = "2016-12-06"
  s.description = "Provides swappable XML backends utilizing LibXML, Nokogiri, Ox, or REXML."
  s.email = "sferik@gmail.com"
  s.homepage = "https://github.com/sferik/multi_xml"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.5.1"
  s.summary = "A generic swappable back-end for XML parsing"

  s.installed_by_version = "2.4.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, ["~> 1.0"])
    else
      s.add_dependency(%q<bundler>, ["~> 1.0"])
    end
  else
    s.add_dependency(%q<bundler>, ["~> 1.0"])
  end
end
