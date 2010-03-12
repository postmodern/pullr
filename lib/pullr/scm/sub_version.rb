require 'pullr/command_line'

module Pullr
  module SCM
    module SubVersion
      include CommandLine

      #
      # Pulls down a copy of a SubVersion source repository.
      #
      # @param [Addressable::URI] uri
      #   The URI of the SubVersion repository.
      #
      # @param [String] dest
      #   Optional destination to pull the repository down into.
      #
      def scm_pull(uri,dest=nil)
        if dest
          sh 'svn', 'checkout', uri, dest
        else
          sh 'svn', 'checkout', uri
        end
      end

      #
      # Updates a local SubVersion repository.
      #
      # @param [String] path
      #   Path to the local repository to update.
      #
      # @param [Addressable::URI] uri
      #   Optional URI of the remote SubVersion repository to update from.
      #
      def scm_update(path,uri=nil)
        cd(path) { sh 'svn', 'update' }
      end
    end
  end
end
