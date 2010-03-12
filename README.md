# Pullr

* [pullr.rubyforge.org](http://pullr.rubyforge.org/)
* [github.com/postmodern/pullr](http://github.com/postmodern/pullr/)
* Postmodern (postmodern.mod3 at gmail.com)

## Description

Pullr is a Ruby library for quickly pulling down or updating any Repository.
Pullr currently supports Git, Mercurial (Hg), SubVersion (SVN) and Rsync.

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

    $ pullr git://github.com/datamapper/dm-rails.git /home/dm-rails

Pull down a repository from a generic HTTP URL:

    $ pullr http://www.tortall.net/svn/yasm/trunk/yasm -S svn

Update an existing repository:

    $ cd yasm
    $ pullr -u

## Examples

## Requirements

* [addressable](http://addressable.rubyforge.org/) >= 0.2.1

## Install

    $ sudo gem install pullr

## License

See {file:LICENSE.txt} for license information.

