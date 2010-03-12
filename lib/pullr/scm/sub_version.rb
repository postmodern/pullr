module Pullr
  module SCM
    module SubVersion
      protected

      def clone(uri,dest=nil)
        if dest
          sh 'svn', 'checkout', uri, dest
        else
          sh 'svn', 'checkout', uri
        end
      end

      def pull(path,uri=nil)
        cd(path) { sh 'svn', 'update' }
      end
    end
  end
end
