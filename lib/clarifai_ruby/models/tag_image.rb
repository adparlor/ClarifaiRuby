module ClarifaiRuby
  class TagImage
    attr_reader :tags, :tags_by_words

    def initialize(response_doc)
      @tags = generate_tags response_doc
      @tags_by_words = @tags.map(&:word)
    end

    private

    def generate_tags(tag_doc)
      tag_doc.map { |tag| Tag.new(tag['name'], tag['value'], tag['id']) }
    end
  end
end
