require 'pullr/command_line'

module Pullr
  module SCM
    module Git
      include CommandLine

      #
      # Makes a clone of the git source repository as the new local copy
      # of the project.
      #
      def scm_pull(uri,dest=nil)
        if dest
          sh 'git', 'clone', uri, dest
        else
          sh 'git', 'clone', uri
        end
      end

      #
      # Updates the local repository.
      #
      def scm_update(path,uri=nil)
        cd(path) do
          sh 'git', 'reset', '--hard', 'HEAD'
          sh 'git', 'pull'
        end
      end
    end
  end
end
