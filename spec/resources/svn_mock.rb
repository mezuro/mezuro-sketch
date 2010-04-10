module Svn
  module Client
    class Context
      def checkout(url, path, revision=nil, peg_rev=nil,
                   depth=nil, ignore_externals=false,
                   allow_unver_obstruction=false)
        FileUtils.mkdir_p path
      end
    end
  end
end
