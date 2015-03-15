require 'tesseract-ocr'
require 'open-uri'
require 'mechanize'
require 'pry'

module OcrEngine
  class BaseEngine
    def initialize
      @ocr_engine = Tesseract::Engine.new { |e|
        e.language = :eng
        e.blacklist = '|'
      }
      @scraper = Scraper.new
    end

    def ocr_engine
      @ocr_engine
    end
    
    def text_for(im)
      @ocr_engine.text_for(im).strip! 
    end

    def get_memes
      @scraper.image_links('http://www.reddit.com/r/memes').map { |m|
        binding.pry 
      }
    end
  end

  class Scraper
    def initialize
      @browser = Mechanize.new { |b| 
        b.user_agent_alias = 'Mac Safari'
      }
    end
    
    def browser 
      @browser
    end

    def get(url)
      @browser.get(url)
    end

    def image_links(url)
      get(url).links.map { |l| l.uri.to_s if check_link(l.uri.to_s) }.compact!
    end

    private

    def check_link(link)
      link.include? 'png'
    end
  end
end

