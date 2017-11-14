module ClarifaiRuby
  class TagResponse
    attr_reader :tag_creatives,
                :status_code,
                :status_msg,
                :meta,
                :model

    def initialize(json_response, type: :image)
      outputs = json_response['outputs']

      @tag_creatives = generate_tag_creatives_for type: type, outputs: outputs
      @status_code = json_response['status']['code']
      @status_msg = json_response['status']['description']
      @meta = outputs.first['model']
      @model = outputs.first['model']['model_version']
    end

    private

    def generate_tag_creatives_for(type: :image, outputs: outputs)
      outputs.map do |results|
        concepts = results['data']['concepts']
        if type == :video
          TagVideo.new(concepts)
        else
          TagImage.new(concepts)
        end
      end
    end
  end
end
