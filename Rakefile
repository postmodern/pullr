require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:development, :doc)
rescue Bundler::BundlerError => e
  STDERR.puts e.message
  STDERR.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'rake'
require 'jeweler'
require './lib/pullr/version.rb'

Jeweler::Tasks.new do |gem|
  gem.name = 'pullr'
  gem.version = Pullr::VERSION
  gem.license = 'MIT'
  gem.summary = %Q{A Ruby library for quickly pulling down or updating any Repository.}
  gem.description = %Q{Pullr is a Ruby library for quickly pulling down or updating any Repository. Pullr currently supports Git, Mercurial (Hg), SubVersion (SVN) and Rsync. Pullr provides a command-line utility and an API which can be used by other frameworks.}
  gem.email = 'postmodern.mod3@gmail.com'
  gem.homepage = 'http://github.com/postmodern/pullr'
  gem.authors = ['Postmodern']
  gem.has_rdoc = 'yard'
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs += ['lib', 'spec']
  spec.spec_files = FileList['spec/**/*_spec.rb']
  spec.spec_opts = ['--options', '.specopts']
end

task :default => :spec

require 'yard'
YARD::Rake::YardocTask.new
