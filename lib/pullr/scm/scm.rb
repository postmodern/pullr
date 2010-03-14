require 'pullr/exceptions/unknown_scm'
require 'pullr/scm/git'
require 'pullr/scm/mercurial'
require 'pullr/scm/sub_version'
require 'pullr/scm/rsync'

module Pullr
  module SCM
    # Mapping of known SCM names and their respective mixins
    NAMES = {
      :git => Git,
      :mercurial => Mercurial,
      :hg => Mercurial,
      :sub_version => SubVersion,
      :subversion => SubVersion,
      :svn => SubVersion,
      :rsync => Rsync
    }

    # Mapping of known URI schemes and their respective SCM names
    SCHEMES = {
      'git' => :git,
      'hg' => :mercurial,
      'svn' => :sub_version,
      'svn+ssh' => :sub_version,
      'rsync' => :rsync
    }

    # Mapping of URI path extensions and their respective SCM names
    EXTS = {
      '.git' => :git
    }

    # Mapping of directories and the SCMs that use them
    DIRS = {
      '.git' => :git,
      '.hg' => :mercurial,
      '.svn' => :sub_version
    }

    #
    # Attempts to infer the SCM used for the remote repository.
    #
    # @param [Addressable::URI] uri
    #   The URI to infer the SCM from.
    #
    # @return [Symbol]
    #   The name of the infered SCM.
    #
    def SCM.infer_from_uri(uri)
      uri_scheme = uri.scheme

      if (scm = SCM::SCHEMES[uri_scheme])
        return scm
      end

      uri_ext = File.extname(uri.path)

      if (scm = SCM::EXTS[uri_ext])
        return scm
      end

      return nil
    end

    #
    # Attempts to infer the SCM used to manage a given directory.
    #
    # @param [String] path
    #   The path to the directory.
    #
    # @return [Symbol]
    #   The name of the infered SCM.
    #
    def SCM.infer_from_dir(path)
      SCM::DIRS.each do |name,scm|
        if File.directory?(File.join(path,name))
          return scm
        end
      end

      return nil
    end

    #
    # Finds the SCM mixin for a given SCM name.
    #
    # @param [Symbol, String] name
    #   The name of the SCM.
    #
    # @return [Module]
    #   The SCM mixin.
    #
    # @raise [UnknownSCM]
    #   The SCM name did not map to a known SCM mixin.
    #
    def SCM.lookup(name)
      name = name.to_sym

      unless NAMES.has_key?(name)
        raise(UnknownSCM,"unknown SCM #{name}",caller)
      end

      return NAMES[name]
    end
  end
end
