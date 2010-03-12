module Pullr
  module SCM
    module Rsync
      protected

      def clone(uri,dest)
        sh 'rsync', '-a', rsync_uri(uri), dest
      end

      def pull(path,uri=nil)
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
