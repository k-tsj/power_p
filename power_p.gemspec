# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'power_p/version'

Gem::Specification.new do |spec|
  spec.name          = 'power_p'
  spec.version       = PowerP::VERSION
  spec.authors       = ['Kazuki Tsujimoto']
  spec.email         = ['kazuki@callcc.net']
  spec.summary       = %q{Extend Kernel#p with power_assert}
  spec.description   = %q{Extend Kernel#p with power_assert}
  spec.homepage      = 'https://github.com/k-tsj/power_p'

  spec.files            = `git ls-files`.split("\n")
  spec.test_files       = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.executables      = `git ls-files -- bin/*`.split("\n").map{|f| File.basename(f) }
  spec.require_paths    = ['lib']

  spec.add_runtime_dependency 'power_assert', '>= 1.1.0'
  spec.add_development_dependency 'test-unit'
  spec.add_development_dependency 'rake'
  spec.extra_rdoc_files = ['README.rdoc']
  spec.rdoc_options     = ['--main', 'README.rdoc']
end
