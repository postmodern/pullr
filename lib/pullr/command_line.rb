module Pullr
  module CommandLine
    #
    # Changes directories.
    #
    # @param [String] path
    #   Path to the new directory.
    #
    # @yield []
    #   If a block is given, then the directory will only be changed
    #   temporarily, then changed back after the block has finished.
    #
    def cd(path,&block)
      if block
        pwd = Dir.pwd
        Dir.chdir(path)

        block.call()

        Dir.chdir(pwd)
      else
        Dir.chdir(path)
      end
    end

    #
    # Runs a command.
    #
    # @param [String] program
    #   The name or path of the program to run.
    #
    # @param [Array<String>] args
    #   The additional arguments to run with the program.
    #
    def sh(program,*args)
      system(program,*args)
    end
  end
end
