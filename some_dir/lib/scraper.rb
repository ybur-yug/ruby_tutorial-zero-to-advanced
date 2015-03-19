require 'mechanize'
require 'pry'

$AMAZON_URL = 'http://www.amazon.com/'

module Scraper 
  class Browser 
    def initialize
      @browser = Mechanize.new { |x| x.user_agent_alias = "Mac Safari" }
      @amazon = browser.get($AMAZON_URL)
    end

    def browser
      @browser
    end

    def amazon
      @amazon
    end

    def amazon_search_form()
      @amazon.form_with(class: "nav-searchbar")
    end

    def amazon_search(keywords)
      form = amazon_search_form
      amazon_search_form do |form|
        search_field = form["field-keywords"]
        binding.pry
        search_field = keywords
      end
      @browser.submit(form)
    end
  end
end

