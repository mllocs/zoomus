# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|

  gem.add_dependency 'httparty', '~> 0.13'
  gem.add_dependency 'json', '>= 1.8'

  gem.add_development_dependency 'byebug'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'rspec_junit_formatter'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'webmock'

  gem.authors       = ['Maxim Colls', 'Kyle Boe']
  gem.email         = ['kyle@boe.codes']
  gem.description   = 'A Ruby API wrapper for zoom.us API'
  gem.summary       = 'zoom.us API wrapper'
  gem.homepage      = 'https://github.com/hintmedia/zoom_rb'
  gem.licenses      = ['MIT']

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'zoom_rb'
  gem.require_paths = ['lib']
  gem.version       = '0.8.0'
end
