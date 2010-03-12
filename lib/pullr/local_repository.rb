require 'pullr/exceptions/ambigious_repository'
require 'pullr/repository'

module Pullr
  class LocalRepository

    include Repository

    # The path of the repository
    attr_reader :path

    # The SCM used for the repository
    attr_reader :scm

    # Optional URI for the remote repository
    attr_accessor :uri

    #
    # Initializes the repository.
    #
    # @param [Hash] options
    #   Options for the repository.
    #
    # @option options [String] :path
    #   Path to the repository.
    #
    # @option options [Symbol, String] :scm
    #   The SCM used to manage the repository.
    #
    # @option options [URI::Generic] :uri
    #   Optional URI for the remote repository.
    #
    def initialize(options={})
      @path = options[:path]
      @scm = options[:scm]
      @uri = options[:uri]

      unless @scm
        infer_scm_from_dir && infer_scm_from_uri
      end

      unless @scm
        raise(AmbigiousRepository,"could not infer the SCM from the directory #{@path.dump}",caller)
      end

      extend SCM.lookup(@scm)
    end

    #
    # The control directory used by the SCM.
    #
    # @return [String]
    #   The name of the control directory.
    #
    def scm_dir
      SCM::DIRS[@scm]
    end

    #
    # Pulls any new updates for the repository down.
    #
    # @param [URI::Generic] uri
    #   Optional URI to pull from.
    #
    def update(uri=self.uri)
      super(@path,uri)
    end
  
  end
end
