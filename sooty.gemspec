# -*- encoding: utf-8 -*-
require File.expand_path('../lib/sooty/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["David Winter"]
  gem.email         = ["i@djw.me"]
  gem.description   = %q{Install Puppet via Rake and apply your manifests.}
  gem.summary       = gem.description
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "sooty-puppet"
  gem.require_paths = ["lib"]
  gem.version       = Sooty::VERSION

  gem.add_dependency "rake-remote_task", "~> 2.0.6"
end
