require 'pullr/exceptions/unknown_scm'
require 'pullr/scm/git'
require 'pullr/scm/mercurial'
require 'pullr/scm/sub_version'
require 'pullr/scm/rsync'

module Pullr
  module SCM
    NAMES = {
      :git => Git,
      :mercurial => Mercurial,
      :hg => Mercurial,
      :sub_version => SubVersion,
      :subversion => SubVersion,
      :svn => SubVersion,
      :rsync => Rsync
    }

    # Mapping of known URI schemes and their respective SCMs
    SCHEMES = {
      'git' => :git,
      'hg' => :mercurial,
      'svn' => :sub_version,
      'rsync' => :rsync
    }

    # Mapping of URI path extensions and their respective SCMs
    EXTS = {
      '.git' => :git
    }

    # Mapping of directories and the SCMs that use them
    DIRS = {
      '.git' => :git,
      '.hg' => :mercurial,
      '.svn' => :sub_version
    }

    def SCM.lookup(name)
      name = name.to_sym

      unless NAMES.has_key?(name)
        raise(UnknownSCM,"unknown SCM #{name}",caller)
      end

      return NAMES[name]
    end
  end
end
