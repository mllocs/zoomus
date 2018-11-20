# frozen_string_literal: true

Gem::Specification.new do |gem|

  gem.add_dependency 'httparty', '~> 0.13'
  gem.add_dependency 'json', '~> 2.1'
  gem.add_dependency 'jwt', '~> 2.1'

  gem.add_development_dependency 'pry', '~> 0'
  gem.add_development_dependency 'hint-rubocop_style', '~> 0'
  gem.add_development_dependency 'rspec', '~> 3.8'
  gem.add_development_dependency 'rspec_junit_formatter', '~> 0.4.1'
  gem.add_development_dependency 'simplecov', '~> 0.16.1'
  gem.add_development_dependency 'webmock', '~> 3.4'

  gem.authors       = ['Kyle Boe']
  gem.email         = ['kyle@boe.codes']
  gem.description   = 'A Ruby API wrapper for zoom.us API'
  gem.summary       = 'zoom.us API wrapper'
  gem.homepage      = 'https://github.com/hintmedia/zoom_rb'
  gem.licenses      = ['MIT']

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'zoom_rb'
  gem.require_paths = ['lib']
  gem.version       = '0.8.4'
end
