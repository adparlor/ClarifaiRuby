module ClarifaiRuby
  class Configuration
    attr_accessor :api_key, :base_url, :version_path

    def initialize
      @base_url = 'https://api.clarifai.com'
      @version_path = '/v2'
    end

    def api_url
      base_url + version_path
    end
  end
end
