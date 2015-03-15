require './ocr_engine.rb'
require 'pry'

describe OcrEngine do
  let(:engine) { OcrEngine.new }
  let(:tess_engine) { OcrEngine.new.ocr_engine }

  describe "#new" do
    it 'creates a new instantiation of the OcrEngine class' do
      expect(engine).to be_an_instance_of OcrEngine
    end
    
    it "creates an engine upon instantiation" do
      expect(engine.ocr_engine).to be_an_instance_of Tesseract::Engine
    end
  end

  describe "when processing images" do
    it "returns text" do
      File.open("#{Dir.pwd}/rb.png") do |file|
        result = tess_engine.text_for(file.read)
        expect(result).to be_an_instance_of String
      end
    end
  end
end

