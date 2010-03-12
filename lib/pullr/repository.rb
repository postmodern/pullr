require 'pullr/exceptions/ambigious_uri'
require 'pullr/exceptions/ambigious_repository'

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
      @uri = options[:uri]
    end

    #
    # Attempts to infer the SCM used for the remote repository.
    #
    # @return [true]
    #   The SCM was successfully infered.
    #
    # @raise [AmbigiousURI]
    #   The URI for the remote repository was ambigious, and the SCM could
    #   not be infered from it.
    #
    def infer_scm_from_uri
      return false unless @uri

      uri_scheme = @uri.scheme

      if (@scm = SCM::SCHEMES[uri_scheme])
        return true
      end

      uri_ext = File.extname(@uri.path)

      if (@scm = SCM::EXTS[uri_ext])
        return true
      end

      raise(AmbigiousURI,"could not infer the SCM used for the URI #{@uri}",caller)
    end

    #
    # Attempts to infer the SCM used for the repository.
    #
    # @return [true]
    #   The SCM was successfully infered.
    #
    # @raise [AmbigiousRepository]
    #   The repository did not contain any known directories used by
    #   various SCMs.
    #
    def infer_scm_from_dir
      return false unless @path

      if @path
        SCM::DIRS.each do |name,scm|
          if File.directory?(File.join(@path,name))
            @scm = scm
            return true
          end
        end

        infer_scm_from_uri

        raise(AmbigiousRepository,"could not infer the SCM from the directory #{@path.dump}",caller)
      end
    end
  end
end
