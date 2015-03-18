require 'mechanize'

$AMAZON_URL = 'http://www.amazon.com/'

module Scraper 
  class Browser 
    def initialize
      @browser = Mechanize.new { |x| x.user_agent_alias = "Mac Safari" }
    end

    def browser
      @browser
    end

    def amazon
      @browser.get($AMAZON_URL)
    end
  end
end

