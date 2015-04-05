require './lib/reddit_wrap'

describe RedditWrap::Engine do
  
  it "has a browser" do
    expect(subject.browser.class).to eq Mechanize
  end
end
