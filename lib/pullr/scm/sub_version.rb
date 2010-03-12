module Pullr
  module SCM
    module SubVersion
      protected

      def clone(uri,dest)
        sh 'svn', 'checkout', uri, dest
      end

      def pull(path,uri=nil)
        cd(path) { sh 'svn', 'update' }
      end
    end
  end
end
