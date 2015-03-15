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

      it "can get text by line" do
        File.open('rb.png') do |file|
          OcrEngine::BaseEngine.new.confidence_and_text(file.read)
        end
      end
    end
  end
end

