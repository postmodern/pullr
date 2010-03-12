module Pullr
  module SCM
    module Mercurial
      protected

      def pull(uri,dest=nil)
        if dest
          sh 'hg', 'clone', uri, dest
        else
          sh 'hg', 'clone', uri
        end
      end

      #
      # Updates the local copy of the project.
      #
      def update(path,uri=nil)
        cd(path) do
          sh 'hg', 'pull'
          sh 'hg', 'update', '-C'
        end
      end
    end
  end
end
