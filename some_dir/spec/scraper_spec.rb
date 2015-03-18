require 'spec_helper'

context "on creation" do
  describe Scraper::Browser do
    let(:browser) { Scraper::Browser.new }

    it "Is in fact a browser" do
      expect(browser.browser.class).to eq Mechanize
    end

    it "can get amazon's main page" do
      expect(browser.amazon.uri.to_s).to eq 'http://www.amazon.com/'
    end
  end
end

