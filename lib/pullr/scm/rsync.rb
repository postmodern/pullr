require 'pullr/command_line'

module Pullr
  module SCM
    module Rsync
      include CommandLine

      #
      # Pulls down a copy of a Rsync source repository.
      #
      # @param [Addressable::URI] uri
      #   The URI of the Rsync repository.
      #
      # @param [String] dest
      #   Optional destination to pull the repository down into.
      #
      def scm_pull(uri,dest=nil)
        unless dest
          raise(ArgumentError,"the destination argument for clone is missing",caller)
        end

        sh 'rsync', '-a', rsync_uri(uri), dest
      end

      #
      # Updates a local Rsync repository.
      #
      # @param [String] path
      #   Path to the local repository to update.
      #
      # @param [Addressable::URI] uri
      #   Optional URI of the remote Rsync repository to update from.
      #
      def scm_update(path,uri=nil)
        unless uri
          raise(ArgumentError,"must specify the 'uri' argument to pull from",caller)
        end

        sh 'rsync', '-v', '-a', '--delete-after', rsync_uri(uri), path
      end

      #
      # Converts a given URI to one compatible with `rsync`.
      #
      # @param [URI::Generic] uri
      #   The URI to convert.
      #
      # @return [String]
      #   The `rsync` compatible URI.
      #
      def rsync_uri(uri)
        new_uri = uri.host

        new_uri = "#{uri.user}@#{new_uri}" if uri.user
        new_uri = "#{new_uri}:#{uri.path}" unless uri.path.empty?

        return new_uri
      end
    end
  end
end
