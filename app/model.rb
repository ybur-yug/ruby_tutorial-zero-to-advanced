require "data_mapper"
require "dm-migrations"
require "dm-sqlite-adapter"

DataMapper.setup(:default, ENV["DATABASE_URL"] || "sqlite3://#{Dir.pwd}/development.sqlite3")

class User
	include DataMapper::Resource

	property :id, Serial
	# ...



end

DataMapper.finalize.auto_upgrade!

class Ocr
  def init
    @engine = Tesseract::Engine.new {|engine|
                engine.language = :lol # arbitrary
                engine.page_segmentation_mode = 4
                engine.whitelist = [*'a'..'z', *'A'..'Z', *0..9].join # thanks ruby, made this easy
              }
  end

  def get_text(im)
    @engine.text_for(im)
  end
end
