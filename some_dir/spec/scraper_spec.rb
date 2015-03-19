require 'spec_helper'
require 'pry'

context "on creation" do
  describe Scraper::Browser do
    let(:browser) { Scraper::Browser.new }

    it "Is in fact a browser" do
      expect(browser.browser.class).to eq Mechanize
    end

    it "can get amazon's main page" do
      expect(browser.amazon.uri.to_s).to eq 'http://www.amazon.com/'
    end

    it "gets the search form from amazon" do
      expect(browser.amazon_search_form.class).to eq Mechanize::Form
    end

    it "can search amazon" do
      binding.pry
    end
  end
end

