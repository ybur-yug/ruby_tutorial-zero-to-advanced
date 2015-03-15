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

[commit link](link)

