require 'clarifai_ruby'
require 'pry'

describe ClarifaiRuby do
  it 'has a version number' do
    expect(ClarifaiRuby::VERSION).not_to be nil
  end

  describe ".configure" do
    let(:api_key) { 'sdkjhfkjsdhkfjahsdk' }
    let(:base_url) { "http://death.star" }
    let(:version_path) { "/v2" }
    let(:expected_api_url) { "http://death.star/v2" }

    before do
      ClarifaiRuby.configure do |config|
        config.base_url = base_url
        config.version_path = version_path
        config.api_key = api_key
      end
    end

    it "sets the expected api_url" do
      expect(ClarifaiRuby.configuration.api_url).to eq expected_api_url
    end

    it "sets the client_id" do
      expect(ClarifaiRuby.configuration.api_key).to eq api_key
    end

    it "sets the version_path" do
      expect(ClarifaiRuby.configuration.version_path).to eq version_path
    end
  end
end
