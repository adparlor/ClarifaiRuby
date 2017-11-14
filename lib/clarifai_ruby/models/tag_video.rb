module ClarifaiRuby
  class TagVideo
    attr_reader :tags, :tags_by_words

    def initialize(response_doc)
      @tags = generate_tags response_doc
      @tags_by_words = @tags.flatten.map(&:word)
    end

    private

    def generate_tags(tag_doc)
      tags = []
      tag_doc.each do |frames|
        tags << frames['data']['concepts'].map do |tag|
          Tag.new(tag['name'], tag['value'], tag['id'])
        end
      end
      tags
    end
  end
end
