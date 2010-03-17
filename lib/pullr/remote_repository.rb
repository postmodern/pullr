require 'pullr/exceptions/ambigious_uri'
require 'pullr/repository'
require 'pullr/local_repository'

module Pullr
  class RemoteRepository

    include Repository

    # The SCM that manages the remote repository
    attr_reader :scm

    # The URI of the remote repository
    attr_reader :uri

    #
    # Initializes the remote repository.
    #
    # @param [Hash] options
    #   Options for the remote repository.
    #
    # @option options [URI::Generic] :uri
    #   The URI of the remote repository.
    #
    # @option options [Symbol, String] :scm
    #   The SCM used for the remote repository.
    #
    def initialize(options={})
      super(options)

      infer_scm_from_uri unless @scm

      unless @scm
        raise(AmbigiousURI,"could not infer the SCM used for the URI #{@uri}",caller)
      end

      extend SCM.lookup(@scm)
    end

    #
    # The name of the repository.
    #
    # @return [String]
    #   The remote repository name.
    #
    # @since 0.1.2
    #
    def name
      dirs = File.expand_path(@uri.path).split(File::SEPARATOR)

      unless dirs.empty?
        if @scm == :sub_version
          if dirs[-1] == 'trunk'
            dirs.pop
          elsif (dirs[-2] == 'branches' || dirs[-2] == 'tags')
            dirs.pop
            dirs.pop
          end
        elsif @scm == :git
          dirs.last.gsub!(/\.git$/,'') if dirs.last =~ /\.git$/
        end
      end

      return (dirs.last || @uri.host)
    end

    #
    # Clones the remote repository into the given destination.
    #
    # @param [String] dest
    #   The destination directory to clone the repository into.
    #
    # @return [Repository]
    #   The cloned repository.
    #
    def pull(dest=nil)
      scm_pull(@uri,dest)

      return LocalRepository.new(:path => dest, :scm => @scm)
    end

  end
end
