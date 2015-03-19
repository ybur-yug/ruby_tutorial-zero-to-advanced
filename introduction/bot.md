# Building Something More Complex

Now, this `Bob` class and any test we have written, let us be honest with ourselves, they are the
very definition of trivial. However, we now have a scaffold that will let us build a more complex
application. In order to do this were going to do a few things. First, we should start utilizing
`git`. 

~~~BASH
git init
git add .
git commit -m 'initial commit'
~~~

Now, in order to read about git, I heavily recommend [The Git Book](http://www.gitbook.com) if you want an in
depth primer. However, if you want the basic idea of git, here is what it allows us to do:
we have a very simple way of tracking line by line changes in a document, that are stored on a
tree. We can branch from this, diff work, and combine work. It is a wonderful tool and considered
a standard part of the arsenal for any Rubyist. Now, how about we make this class something
that actually seems to have a goal. Why not make a Ruby interface that will allow us to search
Amazon. This could be fun!

~~~BASH
git mv lib/bob.rb lib/scraper.rb
git mv spec/my_first_spec.rb spec/scraper_spec.rb
editor lib/scraper_spec.rb
~~~

~~~RUBY
require './lib/scraper'

describe Scraper do
  let(:browser) { Scraper::Browser.new }
  it "is in fact a Browser" do
    expect(browser.class).to eq Mechanize
  end
end
~~~

With these changes, we should get a new failure when we run all of these.

`rspec spec/scraper_spec.rb`

~~~
bobby@devbox:~/ruby_tutorial-ocr/some_dir$ rspec spec/scraper_spec.rb 
/home/bobby/ruby_tutorial-ocr/some_dir/spec/scraper_spec.rb:3:in 
<top (required)>: uninitialized constant Scraper::Brwoser (NameError)

~~~

A new failure. So now we can modify the old class to make it passing!

`editor lib/scraper.rb`

~~~RUBY
require 'mechanize'

module Scraper 
  class Browser 
    def initialize
      @browser = Mechanize.new { |x| x.user_agent_alias = "Mac Safari" }
    end

    def browser
      @browser
    end
  end
end

~~~
There is quite a bit of change here so we will break it down piece by piece.

First of all, we have created a module to wrap everything in. This provides
us not only an easy way to package whatever we make with other Ruby code,
but also provides us a way to start thinking about bigger architecture.
Inside the module Scraper, we make a class `Browser`. This class, when instantiated will spawn
a Mechanize instance that is using the Mac Safari user agent alias. Now that we have this, we
will be able to go out and scrape some data to get things from amazing.com via our Ruby wrapper.

Time for another test:

~~~RUBY
...
    it "can get amazon's main page" do
      expect(browser.amazon.uri.to_s).to eq 'http://www.amazon.com/'
    end
...
~~~

Now, we know this will fail, but we pop into our module:

`editor lib/scraper.rb`

~~~RUBY
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

~~~

By defining the constant `AMAZON_URL` and also getting the page, we now have successfully reached
Amazon. Time to find the search form.

## Automating Testing
`Guard` is a systems tool and Gem that will allow us to trivially run our specs whenever they change. In order to use guard,
we first make some gemfile changes:

~~~RUBY
source "https://rubygems.org"

gem "mechanize"
# gem "tesseract-ocr" for later ;)

group :test, :development do
  gem "rspec"
  gem "guard"
  gem "guard-rspec"
  gem "guard-bundler"
end

~~~

This sets us up with guard, and the related plugins that will allow us to run it easily. Now that we are getting robust with
our testing, we are going to make what is commonly known as a `spec_helper` as well.

`editor spec/spec_helper.rb`

~~~RUBY
$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'scraper'
~~~
Now, we will be loading by default all our modules in here so our specs can just `'require spec_helper'` and we will be good
to go. So let's make that change at the top

`editor spec/scraper_spec.rb`

~~~
require 'spec_helper'
...
~~~

and now we can run

`bundle exec guard init`

And any time we change one of our tests, it will automatically run. Try it out!
#### [Interacting With the Web Using Our Bot](/introduction/bot_two.md)
