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
    # Clones the remote repository into the given destination.
    #
    # @param [String] dest
    #   The destination directory to clone the repository into.
    #
    # @return [Repository]
    #   The cloned repository.
    #
    def pull(dest)
      scm_pull(@uri,dest)

      return LocalRepository.new(:path => dest, :scm => @scm)
    end

  end
end
