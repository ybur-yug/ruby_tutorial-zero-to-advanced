# Building Something More Complex

Now, this `Bob` class and any test we have written, let us be honest with ourselves, they are the
very definition of trivial. However, we now have a scaffold that will let us build a more complex
application. In order to do this were going to do a few things. First, we should start utilizing
`git`. We will also use `bundler` to make this a `gem` for the sake of modularity

~~~BASH
$ bundle baller_gem # you can pick whatever name you want. I will keep using baller_gem
$ cd baller_gem
$ git init
$ git add .
$ git commit -m 'initial commit'
~~~

Now, in order to read about git, I heavily recommend [The Git Book](http://www.gitbook.com) if you want an in
depth primer. However, if you want the basic idea of git, here is what it allows us to do:
we have a very simple way of tracking line by line changes in a document, that are stored on a
tree. We can branch from this, diff work, and combine work. It is a wonderful tool and considered
a standard part of the arsenal for any Rubyist. Now, how about we make this class something
that actually seems to have a goal. Why not make a Ruby interface that will allow us to search
Amazon. This could be fun!

~~~BASH
$ ls
Gemfile  lib  LICENSE.txt  Rakefile  README.md	reddit_wrap.gemspec
~~~

If we check out the structure of our gem, it seems pretty simple. A Rakefile will allow us to install, release, and test our gem. 
The README.md is quite self explanatory. We've got a lib directory to keep our main code, a license, and a gemspec. The gemspec
is our first visit.

`editor reddit_wrap.gemspec`

```RUBY
# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'reddit_wrap/version'

Gem::Specification.new do |spec|
  spec.name          = "reddit_wrap"
  spec.version       = RedditWrap::VERSION
  spec.authors       = ["Robert H Grayson II"]
  spec.email         = ["bobbygrayson@gmail.com"]
  spec.summary       = %q{TODO: Write a short summary. Required.}
  spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
```

It appears that all we really need to do is add some descriptions! However, not so fast. Since this is a gem we have to list
other gems we will use as dependencies in here. We will be utilizing the Mechanize gem for this project, so we need to add the line:

`spec.add_development_dependency "mechanize"`

And with that, we can start writing some tests and get hacking!

```BASH
$ mkdir spec
$ editor spec/reddit_wrap_spec.rb
```

~~~RUBY
require './lib/reddit_wrap'

describe Scraper do
  let(:browser) { Scraper::Browser.new }
  it "is in fact a Browser" do
    expect(browser.class).to eq Mechanize
  end
end
~~~

With these changes, we should get a failure.

`rspec spec/scraper_spec.rb`

~~~
devbox% rspec spec 
/home/bobby/projects/ruby_tutorial-ocr/reddit_wrap/spec/reddit_wrap_spec.rb:3:in `<top (required)>': uninitialized constant RedditWrap::Engine (NameError)
	from /var/lib/gems/2.1.0/gems/rspec-core-3.1.7/lib/rspec/core/configuration.rb:1105:in `load'
	from /var/lib/gems/2.1.0/gems/rspec-core-3.1.7/lib/rspec/core/configuration.rb:1105:in `block in load_spec_files'
	from /var/lib/gems/2.1.0/gems/rspec-core-3.1.7/lib/rspec/core/configuration.rb:1105:in `each'
	from /var/lib/gems/2.1.0/gems/rspec-core-3.1.7/lib/rspec/core/configuration.rb:1105:in `load_spec_files'
	from /var/lib/gems/2.1.0/gems/rspec-core-3.1.7/lib/rspec/core/runner.rb:96:in `setup'
	from /var/lib/gems/2.1.0/gems/rspec-core-3.1.7/lib/rspec/core/runner.rb:84:in `run'
	from /var/lib/gems/2.1.0/gems/rspec-core-3.1.7/lib/rspec/core/runner.rb:69:in `run'
	from /var/lib/gems/2.1.0/gems/rspec-core-3.1.7/lib/rspec/core/runner.rb:37:in `invoke'
	from /var/lib/gems/2.1.0/gems/rspec-core-3.1.7/exe/rspec:4:in `<top (required)>'
	from /usr/local/bin/rspec:23:in `load'
	from /usr/local/bin/rspec:23:in `<main>'

~~~

Now, we need to get that to actually exist.

`editor lib/reddit_wrap.rb`

~~~RUBY
requier 'reddit_wrap/version'
require 'mechanize'

module RedditWrap 
  class Engine 
    attr_accessor :browser
    def initialize
      @browser = Mechanize.new { |x| x.user_agent_alias = "Mac Safari" }
    end
  end
end

~~~
There is quite a bit of change here so we will break it down piece by piece.

First of all, we have created a module to wrap everything in. This provides
us not only an easy way to package whatever we make with other Ruby code,
but also provides us a way to start thinking about bigger architecture.
Inside the module Scraper, we make a class `Engine`. This class, when instantiated will spawn
a Mechanize instance that is using the Mac Safari user agent alias. Now that we have this, we
will be able to go out and scrape some data to get things from amazing.com via our Ruby wrapper.

Let's see if our specs pass now:

`bundle exec rspec spec/reddit_wrap_spec.rb`

```BASH
$ rspec spec/reddit_wrap_spec.rb 
.

Finished in 0.01348 seconds (files took 3.65 seconds to load)
1 example, 0 failures

```
Passing!

Time for another test:

~~~RUBY
...
    it "can get reddit's main page" do
      expect(browser.reddit.uri.to_s).to eq 'http://www.reddit.com/'
    end
...
~~~

Now, we know this will fail, but we pop into our module:

`editor lib/reddit_wrap.rb`

~~~RUBY
require 'mechanize'

$REDDIT_URL = 'http://www.reddit.com/'

module RedditWrap 
  class Engine 
    attr_accessor :browser
    attr_accessor :reddit
    
    def initialize
      @browser = Mechanize.new { |x| x.user_agent_alias = "Mac Safari" }
      @reddit = @browser.get($REDDIT_URL)
    end
  end
end

~~~

By defining the global `$REDDIT_URL` and also getting the page, we now have successfully reached
something. Time to find the signin form. But first, we should implement a more robust dev env.

## Automating Testing
`Guard` is a systems tool and Gem that will allow us to trivially run our specs whenever they change. In order to use guard,
we first make some gemspec changes:

~~~RUBY
...
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "guard-bundler"
...
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

`editor spec/reddit_wrap_spec.rb`

~~~
require 'spec_helper'
...
~~~

and now we can run

`bundle exec guard init`

And any time we change one of our tests, it will automatically run. Try it out!

#### [Interacting With the Web Using Our Bot](/introduction/bot_two.md)
