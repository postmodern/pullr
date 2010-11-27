require 'pullr/command_line'

module Pullr
  module SCM
    module Git
      include CommandLine

      #
      # Pulls down a copy of a Git source repository.
      #
      # @param [Addressable::URI] uri
      #   The URI of the Git repository.
      #
      # @param [String] dest
      #   Optional destination to pull the repository down into.
      #
      def scm_pull(uri,dest=nil)
        if dest
          sh 'git', 'clone', uri, dest
        else
          sh 'git', 'clone', uri
        end
      end

      #
      # Updates a local Git repository.
      #
      # @param [String] path
      #   Path to the local repository to update.
      #
      # @param [Addressable::URI] uri
      #   Optional URI of the remote Git repository to update from.
      #
      def scm_update(path,uri=nil)
        cd(path) do
          sh 'git', 'reset', '-q', '--hard', 'HEAD'
          sh 'git', 'pull', '-f'
        end
      end
    end
  end
end
