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


