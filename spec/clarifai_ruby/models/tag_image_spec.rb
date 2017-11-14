require 'spec_helper'

describe ClarifaiRuby::TagImage do
  describe '#initialize' do
    subject { described_class.new(response_doc) }
    let(:response_doc) do
      [
        {
          'id' => 'ai_NCH97cfG',
          'name' => 'poppy',
          'value' => 0.996757,
          'app_id' => 'main'
        },
        {
          'id' => 'ai_tBcWlsCp',
          'name' => 'nature',
          'value' => 0.99675226,
          'app_id' => 'main'
        },
        {
          'id' => 'ai_mp9KG5QH',
          'name' => 'grass',
          'value' => 0.99330544,
          'app_id' => 'main'
        }
      ]
    end

    it 'sets tags_by_words' do
      expect(subject.tags_by_words).to eq(response_doc.map { |resp| resp['name'] })
    end

    it 'sets tags as Tag objects' do
      subject.tags.each do |tag|
        expect(tag).to be_a ClarifaiRuby::Tag
      end
    end

    it 'sets the correct words' do
      subject.tags.each_with_index do |tag, i|
        expect(tag.word).to eq(response_doc.map { |resp| resp['name'] }[i])
      end
    end

    it 'sets the correct probs' do
      subject.tags.each_with_index do |tag, i|
        expect(tag.prob).to eq(response_doc.map { |resp| resp['value'] }[i])
      end
    end

    it 'sets the correct concept ids' do
      subject.tags.each_with_index do |tag, i|
        expect(tag.concept_id).to eq(response_doc[i]['id'])
      end
    end
  end
end
