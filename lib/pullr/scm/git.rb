module Pullr
  module SCM
    module Git
      protected

      #
      # Makes a clone of the git source repository as the new local copy
      # of the project.
      #
      def clone(uri,dest)
        sh 'git', 'clone', uri, dest
      end

      #
      # Updates the local repository.
      #
      def pull(path,uri=nil)
        cd(path) do
          sh 'git', 'reset', '--hard', 'HEAD'
          sh 'git', 'pull'
        end
      end
    end
  end
end
