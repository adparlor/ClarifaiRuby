require 'spec_helper'

describe ClarifaiRuby::TagVideo do
  describe '#initialize' do
    subject { described_class.new(response_doc) }

    let(:response_doc) do
      JSON.parse(File.read('spec/fixtures/video_response.json'))['outputs'].first['data']['frames']
    end

    it 'sets tags_by_words' do
      expect(subject.tags_by_words.first).to eq('nature')
    end

    it 'sets tags as array of Tag objects for each second of the video' do
      subject.tags.each do |tag|
        expect(tag).to be_a Array
        expect(tag.first).to be_a ClarifaiRuby::Tag
      end
    end

    it 'sets the correct words' do
      subject.tags.each_with_index do |tags_by_second, i|
        tags_by_second.each_with_index do |tag, j|
          expect(tag.word).to eq response_doc[i]['data']['concepts'][j]['name']
        end
      end
    end

    it 'sets the correct probs' do
      subject.tags.each_with_index do |tags_by_second, i|
        tags_by_second.each_with_index do |tag, j|
          expect(tag.prob).to eq response_doc[i]['data']['concepts'][j]['value']
        end
      end
    end

    it 'sets the correct concept ids' do
      subject.tags.each_with_index do |tags_by_second, i|
        tags_by_second.each_with_index do |tag, j|
          expect(tag.concept_id).to eq response_doc[i]['data']['concepts'][j]['id']
        end
      end
    end
  end
end
