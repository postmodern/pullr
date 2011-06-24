require 'pullr/local_repository'
require 'pullr/remote_repository'

require 'optparse'

module Pullr
  class CLI

    #
    # Initializes the Command Line Interface (CLI).
    #
    def initialize
      @scm = nil
      @uri = nil
      @path = nil
      @mode = :clone
      @args = []
    end

    #
    # Runs the Command Line Interface (CLI).
    #
    def CLI.run
      self.new.run(*ARGV)
    end

    #
    # Runs the Command Line Interface (CLI) with the given arguments.
    #
    # @param [Array<String>] args
    #   Arguments to run the CLI with.
    #
    def run(*args)
      optparse(*args)

      case @mode
      when :clone
        @uri ||= @args[0]

        unless @uri
          $stderr.puts "pullr: missing the URI argument"
          exit -1
        end

        repo = RemoteRepository.new(
          :uri => @uri,
          :scm => @scm
        )

        repo.pull(@path || @args[1])
      when :update
        repo = LocalRepository.new(
          :uri => @uri,
          :path => @path,
          :scm => @scm
        )

        repo.update
      end
    end

    protected

    #
    # Parses the given arguments.
    #
    # @param [Array<String>] args
    #   The command-line arguments.
    #
    def optparse(*args)
      opts = OptionParser.new

      opts.banner = 'usage: pullr URI [PATH]'

      opts.on('-S','--scm NAME','Source Code Management to use') do |scm|
        @scm = scm
      end

      opts.on('-U','--uri URI','The URI of the repository') do |uri|
        @uri = uri
      end

      opts.on('-u','--update [PATH]','Update the repository') do |path|
        @mode = :update
        @path = (path || Dir.pwd)
      end

      begin
        @args = opts.parse!(args)
      rescue OptionParser::InvalidOption => e
        $stderr.puts e.message
        $stderr.puts opts
        exit -1
      end
    end

  end
end
