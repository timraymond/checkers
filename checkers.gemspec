# -*- encoding: utf-8 -*-
require File.expand_path('../lib/checkers/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Tim Raymond"]
  gem.email         = ["xtjraymondx@gmail.com"]
  gem.description   = %q{A Checkers engine, with AI}
  gem.summary       = %q{Provides implementations for a Checkers Board, Game, and AI}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "checkers"
  gem.require_paths = ["lib"]
  gem.version       = Checkers::VERSION

  gem.add_development_dependency "rspec"
  gem.add_development_dependency "cover_me"
  gem.add_development_dependency "guard-rspec"
end
