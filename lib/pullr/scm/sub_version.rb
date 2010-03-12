module Pullr
  module SCM
    module SubVersion
      protected

      def pull(uri,dest=nil)
        if dest
          sh 'svn', 'checkout', uri, dest
        else
          sh 'svn', 'checkout', uri
        end
      end

      def update(path,uri=nil)
        cd(path) { sh 'svn', 'update' }
      end
    end
  end
end
