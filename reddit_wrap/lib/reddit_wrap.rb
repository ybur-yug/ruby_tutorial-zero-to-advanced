require "reddit_wrap/version"
require "mechanize"

module RedditWrap
  class Engine
    attr_accessor :browser

    def initialize
      @browser = Mechanize.new { |a| a.user_agent_alias = 'Mac Safari' }
    end
  end
end
