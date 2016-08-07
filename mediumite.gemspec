# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mediumite/version'

Gem::Specification.new do |spec|
  spec.name          = "mediumite"
  spec.version       = Mediumite::VERSION
  spec.authors       = ["Kentaro Takiguchi"]
  spec.email         = ["takiguchi0817@gmail.com"]

  spec.summary       = %q{Simple wrapper for the Medium API written in Ruby.}
  spec.description   = %q{Simple wrapper for the Medium API written in Ruby.}
  spec.homepage      = "https://github.com/rejasupotaro/mediumite"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "sawyer"
  spec.add_development_dependency "pry"
end
