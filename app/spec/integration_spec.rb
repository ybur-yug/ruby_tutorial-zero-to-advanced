require './ocr_engine.rb'

describe OcrEngine do
  let(:engine) { OcrEngine.new }

  describe "#new" do
    it 'creates a new instantiation of the OcrEngine class' do
      expect(engine).to be_an_instance_of OcrEngine
    end
    
    it "creates an engine upon instantiation" do
      expect(engine.ocr_engine).to be_an_instance_of Tesseract::Engine
    end
  end
end

