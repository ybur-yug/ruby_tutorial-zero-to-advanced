require "sinatra/base"

class App < Sinatra::Base
  base = File.dirname(__FILE__)
  set :root, base

  # Function allows both get / post.
  def self.get_or_post(path, opts={}, &block)
    get(path, opts, &block)
    post(path, opts, &block)
  end   

  post "/frontpage" do
    "{'penis': 'wut' }"
  end
end

