# encoding: utf-8

$:.push File.expand_path('../lib', __FILE__)

require 'waddup/version'

Gem::Specification.new do |s|
  s.name        = 'waddup'
  s.version     = Waddup::VERSION
  s.authors     = ['Tim Kurvers']
  s.email       = ['tim@moonsphere.net']
  s.homepage    = 'https://github.com/timkurvers/waddup'
  s.summary     = 'Waddup retraces your activities from arbitrary sources such as version control, issue tracking software and mail clients'
  s.description = 'Waddup retraces your activities from arbitrary sources - such as version control, issue tracking software and mail clients - and displays them in a neat chronological overview'

  s.rubyforge_project = 'waddup'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_dependency 'chronic', '~> 0.10.2'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'

  if RUBY_VERSION >= '1.9.3'
    s.add_development_dependency 'guard'
    s.add_development_dependency 'guard-rspec'
    s.add_development_dependency 'listen'

    s.add_development_dependency 'coveralls'
    s.add_development_dependency 'simplecov'
  end
end
