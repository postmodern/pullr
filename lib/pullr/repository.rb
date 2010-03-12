require 'pullr/scm/scm'

require 'addressable/uri'

module Pullr
  module Repository
    protected

    #
    # Initializes the repository.
    #
    # @param [Hash] options
    #   Options for the repository.
    #
    # @option options [Symbol, String] :scm
    #   The SCM used to manage the repository.
    #
    # @option options [URI::Generic] :uri
    #   Optional URI for the remote repository.
    #
    def initialize(options={})
      @scm = options[:scm]
      @uri = nil

      case options[:uri]
      when Hash
        @uri = Addressable::URI.new(options[:uri])
      when String
        @uri = Addressable::URI.parse(options[:uri])
      end
    end

    #
    # Attempts to infer the SCM used for the remote repository.
    #
    # @return [Boolean]
    #   Specifies whether the SCM was infered from the repository's URI.
    #
    def infer_scm_from_uri
      if @uri
        if (@scm = SCM.infer_from_uri(@uri))
          return true
        end
      end

      return false
    end

    #
    # Attempts to infer the SCM used for the repository.
    #
    # @return [Boolean]
    #   Specifies whether the SCM was successfully infered.
    #
    def infer_scm_from_dir
      if @path
        if (@scm = SCM.infer_from_dir(@path))
          return true
        end
      end

      return false
    end
  end
end
