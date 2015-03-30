require 'mechanize'
require 'pry'

$REDDIT_URL = 'http://www.reddit.com/'

module Scraper 

  class RedditAPI
    attr_accessor :frontpage

    def initialize
      @frontpage = Browser.new.reddit_frontpage
    end
  end

  class Browser 
    attr_accessor :reddit
    attr_accessor :browser

    def initialize
      @browser = Mechanize.new { |x| x.user_agent_alias = "Mac Safari" }
      @reddit = browser.get($REDDIT_URL)
    end

    def reddit_login_form()
      @reddit.forms.last
    end

    def reddit_frontpage
      @reddit.links.map {|l| l if l.dom_class == "title may-blank " }.compact!
    end
  end
end

