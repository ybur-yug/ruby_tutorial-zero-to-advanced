# Basic Syntax

## Getting You Some Ruby
If you are a Mac user, Ruby comes baked in. Open up the `terminal`, that scary
black looking hacker-movies-style thing that has always hung out in your `Applications` section.

Once you have it open, follow along

```BASH
irb
#=>
```
the `#=>` or `>` symbol you will see means it is ready to take input. This is known as our 
interactive ruby shell. It will evaluate Ruby code.

#### TODO windows and linux later

## Playing Around

```RUBY
irb(main):001:0> puts "hello world"
hello world
=> nil
irb(main):002:0>def hello_world
irb(main):003:1>"hello world!"
irb(main):003:1>end
=> :hello_world
irb(main):005:0>
```

So let us break this down a bit. In Ruby, `puts` prints things. It also adds a newline to the
bottom, hence the statement of nil. What we then went on to do is define a function that
returns "hello world!" so that we may call it any time we please. The reason this does
not need `puts` is because in Ruby, a function returns whatever its last line is valued. So, in
this case we are simple returning the string "hello world!" and do not need a return or even a `puts`
statement for this to work perfectly.

## Variables
Time to play with more IRB.

```RUBY
irb
irb(main):001:0> puts a
NameError: undefined local variable or method 'a' for main:Object
  from (irb):1
  from /home/bobby/.rbenv/versions/2.1.0/bin/irb:11:in `<main>`
irb(main):002:0> a = 1
=> 1
puts a
=> 1
b = b
=> nil
```

Wait a second. Be has not been defined, but assigning it to itself returns nil, instead of
a `NameError` as we had been dealing with before.
