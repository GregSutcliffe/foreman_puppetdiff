require File.expand_path('../lib/foreman_puppetdiff/version', __FILE__)
require 'date'

Gem::Specification.new do |s|
  s.name        = 'foreman_puppetdiff'
  s.version     = ForemanPuppetdiff::VERSION
  s.date        = Date.today.to_s
  s.authors     = ['Greg Sutcliffe']
  s.email       = ['greg@emeraldreverie.org']
  s.homepage    = 'https://github.com/GregSutcliffe/foreman_puppetdiff'
  s.summary     = 'Display Puppet catalog diffs in Foreman'
  # also update locale/gemspec.rb
  s.description = <<-DESCRIPTION
This plugin adds a button to the Host page which reaches out to the
proxy on the Host's puppetmaster, and generates a catalog diff using
octocatalog-diff
DESCRIPTION

  s.files = Dir['{app,config,db,lib,locale}/**/*'] + ['LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'deface'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'rdoc'
end
