require 'spec_helper'

describe Scraper::RedditAPI do
  let(:reddit_api) { Scraper::RedditAPI.new }

  it "has a frontpage method easily accessed" do
    expect(reddit_api.frontpage.count).to eq 35
  end
end

describe Scraper::Browser do
  context "on creation" do
    let(:browser) { Scraper::Browser.new }

    it "Is in fact a browser" do
      expect(browser.browser.class).to eq Mechanize
    end

    it "can get reddit's main page" do
      expect(browser.reddit.uri.to_s).to eq 'http://www.reddit.com/'
    end

    it "signs into reddit" do
      form = browser.reddit_login_form
      form = browser.reddit.forms.last
      form['user'] = 'bobbothegrayson'
      form['passwd'] = 'henry63' 
      logged_in_page = form.submit
      expect(browser.reddit.forms.count < logged_in_page.forms.count).to be true
    end

    it "gets the frontpage articles" do
      expect(browser.reddit_frontpage.count).to eq 35
    end
  end
end

