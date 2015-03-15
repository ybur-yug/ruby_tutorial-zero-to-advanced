require 'tesseract-ocr'

class OcrEngine
  def initialize
    @ocr_engine = Tesseract::Engine.new
  end

  def ocr_engine
    @ocr_engine
  end
end

