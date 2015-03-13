## Building A Skeleton
There is a wonderful boierlplate Sintra repository by [karlcoelho](https://github.com/karlcoelho/sinatra-boilerplate) we are going to utilize
for a quick start.

```BASH
git clone https://github.com/karlcoelho/sinatra-boilerplate
mv sinatra-boilerplate app
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

# Upcoming

## Using the CLI via Ruby
## Optimizing Parsing By Row
## Utilizing Confidence
