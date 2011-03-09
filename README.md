# Pullr

* [Source](http://github.com/postmodern/pullr)
* [Issues](http://github.com/postmodern/pullr/issues)
* [Documentation](http://rubydoc.info/gems/pullr)
* Postmodern (postmodern.mod3 at gmail.com)

## Description

Pullr is a Ruby library for quickly pulling down or updating any Repository.
Currently, Pullr supports Git, Mercurial (Hg), SubVersion (SVN) and Rsync.
Pullr provides a command-line utility and an API which can be used by
other frameworks.

## Features

* Currently supports pulling from:
  * Mercurial (Hg)
  * Git
  * SubVersion (SVN)
  * Rsync

## Synopsis

Pull down a repository:

    $ pullr git://github.com/evanphx/rubinius.git

Pull down a repository into a specific directory:

    $ pullr git://github.com/datamapper/dm-rails.git /home/deploy/dm-rails

Pull down a repository from a generic HTTP URL:

    $ pullr http://www.tortall.net/svn/yasm/trunk/yasm -S svn

Update an existing repository:

    $ cd yasm
    $ pullr -u

## Examples

Pull down a repository:

    remote = Pullr::RemoteRepository.new(:uri => 'git://github.com/evanphx/rubinius.git')
    remote.pull
    # => #<Pullr::LocalRepository: ...>

Pull down a repository into a specific directory:

    remote = Pullr::RemoteRepository.new(:uri => 'git://github.com/datamapper/dm-rails.git')
    remote.pull('/home/deploy/dm-rails')
    # => #<Pullr::LocalRepository: ...>

Pull down a repository from a generic HTTP URL:

    remote = Pullr::RemoteRepository.new(:uri => 'http://www.tortall.net/svn/yasm/trunk/yasm', :scm => :svn)
    remote.pull

Update an existing repository:

    local = Pullr::LocalRepository.new(:path => 'yasm')
    local.update

## Requirements

* [addressable](http://addressable.rubyforge.org/) ~> 2.1

## Install

    $ sudo gem install pullr

## Copyright

Copyright (c) 2010 Hal Brodigan

See {file:LICENSE.txt} for license information.

