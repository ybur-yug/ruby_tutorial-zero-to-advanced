# Building The Basis of Our Engine

Now that we have an actual class to toy with, it is time for yet another spec.

```RUBY
...
  describe "when processing images" do
    it "returns strings when getting generic text" do
      File.open("#{Dir.pwd}/rb.png") do |file|
        result = tess_engine.text_for(file.read)
        expect(result).to be_an_instance_of String
      end
    end
  end
...
```

And with no addition to our model, we can now sleep easy knowing that we are cooking with gas.

## Automating Tests
With how much testing we are doing, running these manually will get annoying fast. In order to remedy this,
we can utilize a handy systems tool and Gem called `Guard`. In order to setup guard we must take a few steps.
First, we will add it and some dependencies to our Gemfile, and we will change its structure as well.

`editor Gemfile`

```RUBY
source "https://rubygems.org"

group :test, :development do
  gem "tesseract-ocr"
  gem "rspec"
  gem "guard"
  gem "guard-rspec"
  gem "guard-bundler"
end

```

This gives us guard, and its related tools for rspec and bundler. Now, we can bundle.

`bundle`

and we will be able to generate a Guardfile, which determines the rules for our automated
testing. In a dedicated new terminal window,

`guard init`

`editor Guardfile`

The default Guardfile will appear like so:

```RUBY
# A sample Guardfile
# More info at https://github.com/guard/guard#readme

## Uncomment and set this to only include directories you want to watch
# directories %w(app lib config test spec features)

## Uncomment to clear the screen before every task
# clearing :on

## Guard internally checks for changes in the Guardfile and exits.
## If you want Guard to automatically start up again, run guard in a
## shell loop, e.g.:
##
##  $ while bundle exec guard; do echo "Restarting Guard..."; done
##
## Note: if you are using the `directories` clause above and you are not ## watching the project directory ('.'), then you will want to move ## the Guardfile to a watched dir and symlink it back, e.g.
#
#  $ mkdir config
#  $ mv Guardfile config/
#  $ ln -s config/Guardfile .
#
# and, you'll have to watch "config/Guardfile" instead of "Guardfile"

guard :bundler do
  require 'guard/bundler'
  require 'guard/bundler/verify'
  helper = Guard::Bundler::Verify.new

  files = ['Gemfile']
  files += Dir['*.gemspec'] if files.any? { |f| helper.uses_gemspec?(f) }

  # Assume files are symlinked from somewhere
  files.each { |file| watch(helper.real_path(file)) }
end

# Note: The cmd option is now required due to the increasing number of ways
#       rspec may be run, below are examples of the most common uses.
#  * bundler: 'bundle exec rspec'
#  * bundler binstubs: 'bin/rspec'
#  * spring: 'bin/rspec' (This will use spring if running and you have
#                          installed the spring binstubs per the docs)
#  * zeus: 'zeus rspec' (requires the server to be started separately)
#  * 'just' rspec: 'rspec'

guard :rspec, cmd: "bundle exec rspec" do
  require "guard/rspec/dsl"
  dsl = Guard::RSpec::Dsl.new(self)

  # Feel free to open issues for suggestions and improvements

  # RSpec files
  rspec = dsl.rspec
  watch(rspec.spec_helper) { rspec.spec_dir }
  watch(rspec.spec_support) { rspec.spec_dir }
  watch(rspec.spec_files)

  # Ruby files
  ruby = dsl.ruby
  dsl.watch_spec_files_for(ruby.lib_files)

  # Rails files
  rails = dsl.rails(view_extensions: %w(erb haml slim))
  dsl.watch_spec_files_for(rails.app_files)
  dsl.watch_spec_files_for(rails.views)

  #watch(rails.controllers) do |m|
  #  [
  #    rspec.spec.("routing/#{m[1]}_routing"),
  #    rspec.spec.("controllers/#{m[1]}_controller"),
  #    rspec.spec.("acceptance/#{m[1]}")
  #  ]
  #end

  # Rails config changes
  watch(rails.spec_helper)     { rspec.spec_dir }
  watch(rails.routes)          { "#{rspec.spec_dir}/routing" }
  watch(rails.app_controller)  { "#{rspec.spec_dir}/controllers" }

  # Capybara features specs
  watch(rails.view_dirs)     { |m| rspec.spec.("features/#{m[1]}") }

  # Turnip features and steps
  watch(%r{^spec/acceptance/(.+)\.feature$})
  watch(%r{^spec/acceptance/steps/(.+)_steps\.rb$}) do |m|
    Dir[File.join("**/#{m[1]}.feature")][0] || "spec/acceptance"
  end
end

```

We can comment out the Rails, Capybara, and Turnip sections if we so choose. But we also are going
to make our specs a bit more robust now as well. Let's make a spec helper.

`editor spec/spec_helper.rb`

We are able to make this work quite simply, this is what we will add:

```RUBY
$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'ocr_engine'

```
Now, inside our spec itself

`editor spec/integration_spec.rb`

```
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
```

can replace our current `require` statements.

And now if we make any changes to our spec whatsoever, Guard is properly configured to keep them running
for us. So in our dedicated terminal we initialized guard's files in we will run

`bundle exec guard`

and now, we have auto-tests!

[commit link](link)
