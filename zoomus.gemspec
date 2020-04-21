# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|

  gem.add_dependency 'httparty', '~> 0.13'
  gem.add_dependency 'json', '>= 2.3.0'

  gem.add_development_dependency 'byebug'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'webmock'

  gem.authors       = ['Maxim Colls']
  gem.email         = ['collsmaxim@gmail.com']
  gem.description   = %q{A Ruby wrapper for zoom.us API v1}
  gem.summary       = %q{zoom.us API wrapper}
  gem.homepage      = 'https://github.com/mllocs/zoomus'
  gem.licenses      = ['MIT']

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'zoomus'
  gem.require_paths = ['lib']
  gem.version       = '0.7.0'
end
