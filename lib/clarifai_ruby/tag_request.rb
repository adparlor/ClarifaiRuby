require 'mime/types'

module ClarifaiRuby
  class TagRequest
    attr_reader :raw_response, :options

    def initialize
      @client = Client.new
    end

    def get(url, opts = {})
      media_url = url.split('?').first
      content_type = get_content_type(media_url)
      body = {
        inputs: [
          {
            data: {
              content_type => {
                url: media_url
              }
            }
          }
        ]
      }

      build_request!(body, opts)

      @raw_response = @client.post(tag_path(opts[:model]), body).body
      raise RequestError, @raw_response['status_msg'] if @raw_response['status']['description'].upcase != "OK"

      TagResponse.new(raw_response, type: content_type)
    end

    private

    def get_content_type(file_name)
      content_type = MIME::Types.type_for(file_name.split('?').first)
      if /image/ =~ content_type.first.content_type
        :image
      else
        :video
      end
    end

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
