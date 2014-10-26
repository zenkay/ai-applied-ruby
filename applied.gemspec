# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'applied/version'

Gem::Specification.new do |spec|
  spec.name          = "applied"
  spec.version       = Applied::VERSION
  spec.authors       = ["Andrea Mostosi"]
  spec.email         = ["andrea.mostosi@zenkay.net"]
  spec.summary       = %q{Ruby Gem for AI Applied service}
  spec.description   = %q{Ruby Gem for AI Applied service (ai-applied.nl)}
  spec.homepage      = "https://github.com/zenkay/ai-applied-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '~> 2.0'

  spec.add_dependency "faraday", '~> 0.9', '>= 0.9.0'
  spec.add_dependency "faraday_middleware", '~> 0.9', '>= 0.9.1'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rspec", "~> 2.12"
  spec.add_development_dependency "rake", "~> 10.1"
  spec.add_development_dependency "vcr", "~> 2.4"
  spec.add_development_dependency "webmock", "~> 1.17"
  spec.add_development_dependency "simplecov", "~> 0.8"
  spec.add_development_dependency "coveralls", "~> 0.7"
end
