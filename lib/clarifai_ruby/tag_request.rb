module ClarifaiRuby
  class TagRequest
    attr_reader :raw_response, :options

    def initialize
      @client = Client.new
    end

    def get(image_url, opts = {})
      body = {
        inputs: [
          {
            data: {
              image: {
                url: image_url
              }
            }
          }
        ]
      }

      build_request!(body, opts)

      @raw_response = @client.post(tag_path(opts[:model]), body).body
      raise RequestError.new @raw_response['status_msg'] if @raw_response['status']['description'].upcase != "OK"

      TagResponse.new(raw_response)
    end

    private

    def build_request!(body, opts)
      if opts.has_key? :language
        if body[:model] != "general-v1.3"
          raise RequestError.new "must set model to 'general-v1.3' when using language option"
        end
        body.merge!(language: opts[:language])
      end

      if opts.has_key? :select_classes
        body.merge!(select_classes: opts[:select_classes])
      end
    end

    def tag_path(model = nil)
      "/models/#{model || 'aaa03c23b3724a16a56b629203edc62c'}/outputs"
    end
  end
end
