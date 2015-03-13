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


# Upcoming

## Using the CLI via Ruby
## Optimizing Parsing By Row
## Utilizing Confidence
