# Beginning 
This will be a very by-the-book Ruby tutorial. We will start by simply creating a spec directory,
and inside of it we will write our first failing test.

```BASH
mkdir you_app
cd your_app
mkdir spec
editor spec/integration_spec.rb
```

Now, we will be creating an engine class that we will use to interact with our images. So lets
write a very elementary spec for that.

```RUBY
require './ocr_engine.rb'

describe OcrEngine do
  let(:engine) { OcrEngine.new }

  describe "#new" do
    it "creates a new instantiation of the OcrEngine class" do
      expect(engine).to be_an_instance_of OcrEngine
    end
  end
end
```

`rspec spec/integration_spec.rb`

and we get the output:

```BASH
/home/bobby/ruby_ocr_tutorial/app/spec/integration_spec.rb:1:in 
<top (required)>: uninitialized constant OcrEngine (NameError)
```

So, lets fix that by creating our actual engine class.

`editor ocr_engine.rb`

```RUBY
class OcrEngine
end
```

And now, when we run our spec:

```BASH
Finished in 0.0009 seconds (files took 0.09711 seconds to load)
1 example, 0 failures
```

#### [commit link](link)

## Adding Tesseract
Now, we need to get a tesseract engine up and running in here. To do this we have to take
a few steps. First, we will create a Gemfile

`bundle init`

`editor Gemfile`

```RUBY
source "https://rubygems.org"

gem "tesseract-ocr"

```

Now, we bundle

`bundle`

and we can now begin to add tesseract into our main Ruby class. Time to write another test.

`editor spec/integration_spec.rb`

```RUBY
...    
    it "creates an engine upon instantiation" do
      expect(engine.ocr_engine).to be_an_instance_of Tesseract::Engine
    end
...
```

Now, we just need to get it into our class.

`editor ocr_engine.rb`

and we will add some simple pieces.

```RUBY
require 'tesseract-ocr'

class OcrEngine
  def initialize
    @ocr_engine = Tesseract::Engine.new
  end

  def ocr_engine
    @ocr_engine
  end
end
```

Now, run the tests again:

`rspec spec/integration_spec.rb`

and we get:

```
..

Finished in 0.02948 seconds (files took 0.46664 seconds to load)
2 examples, 0 failures

```

It appears as if we officially can start getting our hands dirty.

#### [commit_link](link)

## An Aside: Forcing A Segfault In Tesseract (Or: Oh shit I broke something)
So, I have NO clue what is broken here, but maybe one of you guys will figure it out and we can fork
and PR a fix if possible. When trying out some samples of images of from books I ran into this issue:

```BASH

[NOTE]
You may have encountered a bug in the Ruby interpreter or extension libraries.
Bug reports are welcome.
For details: http://www.ruby-lang.org/bugreport.html

Aborted (core dumped)
```
And atop it a giant stack trace. If you want to run the executable on it the image is `prince.png` in
the test directory of the project. The stack trace is in [.stack_trace](/.stack_trace). A similar issue is [open on the repo](https://github.com/meh/ruby-tesseract-ocr/issues/37)

Anywho, if someone figures that out I would like to learn what broke.

#### [Part 3](/part_three.md)
