require 'tesseract-ocr'
require 'pry'

module OcrEngine
  class BaseEngine
    def initialize
      @ocr_engine = Tesseract::Engine.new { |e|
        e.language = :eng
        e.blacklist = '|'
      }
    end

    def ocr_engine
      @ocr_engine
    end
    
    def text_for(im)
      @ocr_engine.text_for(im).strip! 
    end
  end
end


