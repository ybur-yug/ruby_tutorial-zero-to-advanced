# Testing
## Why Test?
Rubyists test. It is oft considered a virtue. But why? Testing does more than prove that software
works. There is a great amount of theory that has gone into it, and hundreds of books have been
written on the topic with opinions on the matter usually strong.

What does testing do to you as a programmer? How does it change your habits? If you are doing it
right, it has one obvious change:

#### You are thinking ahead, and in a complete manner.

The benefits of this are obvious. How about we start off by making a very simple failing test.

```BASH
mkdir some_dir
cd some_dir
mkdir spec
editor spec/my_first_spec.rb
```

Now, we can write a simple test. We will start at a very basic level.

```RUBY
let(:bob) { Bob.new }

describe Bob do
  it "can tell you hes wearing pants" do
    expect(bob.pants?).to eq true
  end
end
```

and now, we can save and run our spec

`bundle exec rspec spec/my_first_spec.rb`

but we do not quite get a failure yet:

```BASH
Press ENTER or type command to continue
/home/bobby/ruby_tutorial-ocr/some_dir/my_first_spec.rb:1:in <top (required)>: uninitialized constant Bob (NameError)
```

However, we can solve this. we need to  make a few changes.

`editor spec/my_first_spec.rb`

```RUBY
require './lib/bob'
...
```

If we add this to the top we can now do this:

```BASH
mkdir lib
editor lib/bob.rb
```

and fix it by creating a class `Bob`

```RUBY
class Bob
end

```

and now when we run our spec again,

`rspec spec/my_first_spec.rb`

we get some new output:

```BASH
F

Failures:

  1) Bob can tell you hes wearing pants
       Failure/Error: expect(Bob.pants?).to eq true
            NoMethodError:
                   undefined method pants? for Bob:Class
                        # ./spec/my_first_spec.rb:5:in `block (2 levels) in <top (required)>

                        Finished in 0.00049 seconds (files took 1.41 seconds to load)
                        1 example, 1 failure

                        Failed examples:

                        rspec ./spec/my_first_spec.rb:4 # Bob can tell you hes wearing pants



```

Okay, so now we can fix this to make it passing.

`editor lib/bob.rb`

```RUBY
class Bob
  def pants?
    true
  end
end

```

and we ought to be passing now!

```
bobby@devbox:~/ruby_tutorial-ocr/some_dir$ rspec spec/
.

Finished in 0.02111 seconds (files took 0.11633 seconds to load)
1 example, 0 failures

```

Boom! Passing tests. See, the glory of this is if we have good test coverage, we can change many parts
and know immediately if we have broken anything. We will be writing tests for all the work we do from
here onwards.

#### [Going Deeper](/tesseract/part_one.md)
