## Building A Skeleton
There is a wonderful boierlplate Sintra repository by [karlcoelho](https://github.com/karlcoelho/sinatra-boilerplate) we are going to utilize
for a quick start.

```BASH
git clone https://github.com/karlcoelho/sinatra-boilerplate
mv sinatra-boilerplate app
cd app
bundle
ls
#=> app  app.rb  assets.rbconfig.ru  controller.rb  Gemfile  Gemfile.lock  helpers.rb  LICENSE
model.rb  public  README.md  views
```

Now that we have some defaults set and a basis for an application, lets fire up the server quickly.

`bundle exec ruby app.rb`

This fires our application up on port `4567`, so let us navigate on yonder and see what we get in
the browser. Upon opening it we will find we simply have a nicely styled page that we can access
at the root url. Awesome. Time to open the editor and build our first simple engine. However, what
we will be doing requires some build-up before we can even use it. First, we need to configure a
task to grab an image for us to get text from. Since the internet is full of dank memes, we may
as well just read some dank memes. To do this we will want to install `mechanize`. Your friendly
neighborhood Ruby scraper.

`editor Gemfile`

and we simply add the line

`gem 'mechanize'`

And we can bundle up and start building this out

`bundle install`

#### WIP NOTE: I am literally writing the tutorial as I code this myself. It will be very fluid.
#### If this is of concern, check back and see if there are release tags later. When this is
#### completed I plan on having a commit linked to with a release for each major step to ensure
#### no one can get stuck.
