# Messing With the Page

Now that we have have the page pulled and accessible, lets work on actually exploring it a bit in
order to see exactly what we are playing with here. If you step in and throw some `binding.pry`
statements around, you will easily be able to start playing with the reddit main page from here. 
Take a quick stab and look around. Try `page.forms`, `page.links`, `page.images`, or anything
that comes to mind. What we will first try to do is get the basic frontpage, 35 articles, and then
we will return it to the requester.

```RUBY
require 'mechanize'

$REDDIT_URL = 'http://www.reddit.com/'

module Scraper 
  class Browser 
    attr_accessor :browser
    attr_accessor :reddit
    def initialize
      @browser = Mechanize.new { |x| x.user_agent_alias = "Mac Safari" }
      @reddit = @browser.get($REDDIT_URL)
    end
    
    def reddit_frontpage # our new method
      @reddit.links.map { |l| l if l.dom_class == 'title may-blank ' }.compact!
    end
  end
end

```

If we look at the links in ac actual browser, we can quickly find their class listing by inspecting the element with our
browser. So, we use `map` to return a new array that contains each link with the frontpage-story link's dom class. We run
`.compact!` because of how our if statements work (the arr is populated by `nil`'s where there were no matches due to
the nature of `map` (maintaining the order of the input list).

Now that we have the reddit frontpage, it would be nice to have a sort of API we could use to interact with reddit and 
have this as a base, rather than doing it all with the browser. So let's build another class inside our module quickly.


```
module scraper
  Class RedditAPI
    attr_accessor :frontpage
    def initialize
      @frontpage = Browser.new.reddit_frontpage
  end
  ...
end
```

Well, that we easy. Now to get the front page all we need to do is create an instantiation of `RedditAPI` and call `.frontpage` and we get a list of links. Awesome! Next, we are going to hook this up to the web, RESTful style.

