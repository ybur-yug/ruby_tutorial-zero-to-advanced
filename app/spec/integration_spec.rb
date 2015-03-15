require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'pry'

describe OcrEngine::BaseEngine do
  let(:engine) { OcrEngine::BaseEngine.new }
  let(:tess_engine) { OcrEngine::BaseEngine.new.ocr_engine }
  context "creating an engine" do
    describe "#new" do
      it 'creates a new instantiation of the OcrEngine class' do
        expect(engine).to be_an_instance_of OcrEngine::BaseEngine
      end
      
      it "creates an engine upon instantiation" do
        expect(tess_engine).to be_an_instance_of Tesseract::Engine
      end
    end
  end
  context "processing and parsing" do
    describe "when processing images" do
      it "returns text" do
        File.open('rb.png') do |file|
          result = tess_engine.text_for(file.read)
          expect(result).to be_an_instance_of String
        end
      end
    end
  end
end

describe OcrEngine::Scraper do
  let(:scraper) { OcrEngine::Scraper.new }
  
  context "on creation" do
    it "instantiates a browser" do
      expect(scraper.browser.class).to eq Mechanize
    end
  end
  
  context "in user" do
    it "gets all png meme links from the meme subreddit" do # TODO stub this
      expect(scraper.meme_links('http://www.reddit.com/r/memes').sample.include? 'png').to eq true
    end
  end
end
