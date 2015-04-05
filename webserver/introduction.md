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

## Configuration
In order to deploy this application, we will need what is called a rackup file. These files contain the `.ru` extension and are
commonly used to set up any Rack app. Rack is what Heroku uses, so it's a very good fit for us.

`editor config.ru`

It is quite simple to set up a basic rackup file.

```RUBY
require './app'
use Rack::Deflater
run App.new

```
As you can see, this is quite simple. We require our app, and run it. The middle step involving `Rack::Deflater` can be read about
in depth [here](https://robots.thoughtbot.com/content-compression-with-rack-deflater).


We also will need to setup our server. I like to use `Unicorn` for simple applications like this. To set this up we will add two
additional files.

`editor unicorn.rb`

```RUBY
worker_processes 4
timeout 30
preload_app true
```
Here we set up 4 processes for our workers, set a timeout, and preload the application.
Now we will need a `Procfile` to run it all.

`editor Procfile`

```
web: bundle exec unicorn -p $PORT -c ./unicorn.rb
```

Here we can simply see that we are running the server on a specified port.

Now, we need to make our app itself a little more robust.
