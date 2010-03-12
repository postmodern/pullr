require 'pullr/command_line'

module Pullr
  module SCM
    module Mercurial
      include CommandLine

      #
      # Pulls down a copy of a Mercurial repository.
      #
      # @param [Addressable::URI] uri
      #   The URI of the Mercurial repository.
      #
      # @param [String] dest
      #   Optional destination to pull the repository down into.
      #
      def scm_pull(uri,dest=nil)
        if dest
          sh 'hg', 'clone', uri, dest
        else
          sh 'hg', 'clone', uri
        end
      end

      #
      # Updates a local Mercurial repository.
      #
      # @param [String] path
      #   Path to the local repository to update.
      #
      # @param [Addressable::URI] uri
      #   Optional URI of the remote Mercurial repository to update from.
      #
      def scm_update(path,uri=nil)
        cd(path) do
          sh 'hg', 'pull'
          sh 'hg', 'update', '-C'
        end
      end
    end
  end
end
