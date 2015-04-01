# Plugging Into the Web

## Sinatra
To begin, we are going to add a simple line to our Gemfile.

`editor Gemfile`

and we add the line

```RUBY
gem "sinatra"
```

`bundle`

and now,

`editor lib/scraper.rb`

```RUBY
get "/" do
  reddit = Scraper::RedditAPI.new
  reddit.frontpage.map { |l| "<a href='#{l.uri.to_s}'>#{l.text}</a><br>" }
end
```

If we add this to the bottom of `scraper.rb`, we are doing something quite simple. We are returning
a list of the links wrapped in simple `<a>` tags will now render properly in the browser.

`ruby lib/scraper.rb`

Open up your browser and go to `localhost:4567` and we will now see we have populated the frontpage
of Reddit to our own personal page! Now, let's expand this and dive further into Sinatra and API design.



