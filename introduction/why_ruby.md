# Why Ruby?

## What is Ruby?
Ruby is a programming language. By definition, it is simply a bag of rules and syntax we can use to
communicate with our machines. Ruby is unique in the sense that it has a very, very dedicated group
of followers. You find Ruby user groups easier than just about any other language in many cities.
You hear of people speaking of coming to Ruby as if they had a religious awakening. What about it
is it exactly that so many people seem to be in love?

#### Programmer Happiness.

Ruby is a language met to empower its users. And it does so eloquency. Consider the following Java,
this code is being used to generated all possible one to 3 character strings using english, a very
simple task that I have had pop up personally several times.


```JAVA
class PrintNStrs {
  static void printNLen(char set[]) {
    int k = 3;
    int n = set.length;       
    printNLenRec(set, "", n, k);
  }
    if (k == 0) {
    System.out.println(prefix);
    return;
  }

  for (int i = 0; i < n; ++i) {
    String newPrefix = prefix + set[i];
    printNLenRec(set, newPrefix, n, k - 1);
    }
  }
}

```

And now, let use do it in Ruby...

```RUBY
puts [['a'..'z'], ['aa'..'zz'], ['aaa'..'zzz']]
```

As you can see, the Java programmer had a much longer day.

Ruby seems to have a method for everything. Whenever you think 'I wonder if I can do that?'
*you probably can* and it is awesome. I will go deeper in this section later, but I want to let it
simmer and really think about it.

