# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|

  gem.add_dependency 'httparty'
  gem.add_dependency 'json'

  gem.authors       = ['Maxim Colls']
  gem.email         = ['collsmaxim@gmail.com']
  gem.description   = %q{A Ruby wrapper for zoom.us API v1}
  gem.summary       = %q{zoom.us API wrapper}
  gem.homepage      = 'https://github.com/mllocs/zoomus'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'zoomus'
  gem.require_paths = ['lib']
  gem.version       = '0.0.6'
end
