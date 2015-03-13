## Building A Skeleton
There is a wonderful boierlplate Sintra repository by [karlcoelho](https://github.com/karlcoelho/sinatra-boilerplate) we are going to utilize
for a quick start. It is provided in the repository under the `app` directory.

```BASH
cd app
bundle
ls
#=> 
app  app.rb  assets.rbconfig.ru  controller.rb  Gemfile  Gemfile.lock  helpers.rb  LICENSE
model.rb  public  README.md  views
```

## Testing OCR
Since we have some cool ass OCR software, we ought to try it out. The repository for this Ruby 
wrapper of tesseract comes with an executable. 

`cd ~/ruby-tesseract-ocr/lib/`

With the provided test image in the repository, we can run it on it like so:

`tesseract.rb ~/ruby_ocr_tutorial/test/rb.png`

and we get the output

![img](/test/rb.png)

```
bobby@devbox:~/ruby_ocr_tutorial/ruby-tesseract-ocr/lib$ tesseract.rb ~/ruby_ocr_tutorial/test/rb.png 
RUST
BELT
AM ERICANA
```

Outside of a stray space, it appears we are in business.

## Doing It With Ruby
Let's create an engine now that we have the application skeleton built.

`editor models.rb`

```RUBY
class Ocr
  def init
    @engine = Tesseract::Engine.new {|engine|
      engine.language = :lol # arbitrary
      engine.page_segmentation_mode = 4 # has a default but 4 seems safe
      engine.whitelist = [*'a'..'z', *'A'..'Z', *0..9].join # thanks ruby, made this easy
    }
  end
  def get_text(im)
    @engine.text_for(im)
  end
end
```

As you can see, we simple create a new tesseract engine instance, and give it an arbitrary language,
segment the image, and whitelist some characters. We can blacklist as well, but that is not needed
at the current moment. We also simply wrap the text_for method, but this is just so we can access
it via our class rather than tesseract itself.

## Aside: Forcing A Segfault In Tesseract (Or: Oh shit I broke something)
So, I have NO clue what's broken here, but maybe one of you guys will figure it out and we can fork
and PR a fix if possible. When trying out some samples of png's of from books I ran into this issue:

```BASH

[NOTE]
You may have encountered a bug in the Ruby interpreter or extension libraries.
Bug reports are welcome.
For details: http://www.ruby-lang.org/bugreport.html

Aborted (core dumped)
```

And atop it a giant stack trace. If you want to run the executable on it the image is `prince.png` in
the test directory of the project. The stack trace is in [.stack_trace](/.stack_trace). A similar issue is [open on the repo](https://github.com/meh/ruby-tesseract-ocr/issues/37)

Anywho, if someone figures that out I'd love to learn what broke.

#### [Part 3](/part_three.md)
