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
        @uri ||= ARGV[0]

        unless @uri
          STDERR.puts "pullr: missing the URI argument"
          exit -1
        end

        repo = RemoteRepository.new(
          :uri => (@uri || ARGV[0]),
          :scm => @scm
        )

        repo.pull(@path || ARGV[1])
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
        opts.parse!(args)
      rescue OptionParser::InvalidOption => e
        STDERR.puts e.message
        STDERR.puts opts
        exit -1
      end
    end

  end
end
